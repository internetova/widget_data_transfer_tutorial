import 'package:flutter/material.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/entity/category_type_entity.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/entity/search_filter_entity.dart';

/// Экран фильтра
class FilterPage extends StatefulWidget {
  final SearchFilterEntity filter;

  const FilterPage({Key? key, required this.filter}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  /// Категории пользователя
  final List<CategoryTypeEntity> _userCategories = [];

  @override
  void initState() {
    super.initState();

    _userCategories.addAll(widget.filter.categories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки фильтра'),
        actions: [
          IconButton.outlined(
            onPressed: _clearCategory,
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoryList(
              selectedCategories: _userCategories,
              onPressedCategory: _onPressedCategory,
            ),
            _SaveButton(saveFilter: _userCategories.isEmpty ? null : _saveFilter),
          ],
        ),
      ),
    );
  }

  /// Обработка клика по категории
  void _onPressedCategory(CategoryTypeEntity category) {
    final isSelected = _userCategories.contains(category);

    setState(() {
      if (isSelected) {
        _userCategories.remove(category);
      } else {
        _userCategories.add(category);
      }
    });
  }

  /// Сбросить выбор всех категорий
  void _clearCategory() {
    setState(() {
      _userCategories.clear();
    });
  }

  /// Сохранить фильтр
  /// Передаём на предыдущую страницу новый фильтр
  void _saveFilter() {
    Navigator.pop(
      context,
      SearchFilterEntity(_userCategories),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryTypeEntity category;
  final bool isSelected;
  final ValueChanged<CategoryTypeEntity> onPressedCategory;

  const _CategoryItem({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onPressedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: isSelected ? const Icon(Icons.check) : const Icon(Icons.remove),
      label: Text(category.name),
      backgroundColor: isSelected ? Colors.green[200] : Colors.deepPurple[50],
      shape: const StadiumBorder(),
      onPressed: () => onPressedCategory(category),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final List<CategoryTypeEntity> selectedCategories;
  final ValueChanged<CategoryTypeEntity> onPressedCategory;

  const _CategoryList({
    Key? key,
    required this.selectedCategories,
    required this.onPressedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: CategoryTypeEntity.values
          .map(
            (e) => _CategoryItem(
              category: e,
              isSelected: selectedCategories.contains(e),
              onPressedCategory: onPressedCategory,
            ),
          )
          .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback? saveFilter;

  const _SaveButton({Key? key, this.saveFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FilledButton(
          onPressed: saveFilter,
          child: const Text('Сохранить'),
        ),
      ),
    );
  }
}
