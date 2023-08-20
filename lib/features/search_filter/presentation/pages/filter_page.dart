import 'package:flutter/material.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/entity/category_type_entity.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/entity/search_filter_entity.dart';

/// Экран фильтра
///
/// Пример с доступом через state родительского виджета
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
        actions: const [
          _ClearButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoryList(userCategories: _userCategories),
            const _SaveButton(),
          ],
        ),
      ),
    );
  }

  /// Обработка клика по категории
  void onPressedCategory(CategoryTypeEntity category) {
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
  void clearFilter() {
    setState(() {
      _userCategories.clear();
    });
  }

  /// Сохранить фильтр
  /// Передаём на предыдущую страницу новый фильтр
  void saveFilter() {
    Navigator.pop(
      context,
      SearchFilterEntity(_userCategories),
    );
  }
}

/// Айтем категории
class _CategoryItem extends StatelessWidget {
  final CategoryTypeEntity category;
  final bool isSelected;

  const _CategoryItem({
    Key? key,
    required this.category,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterState = context.findAncestorStateOfType<_FilterPageState>();

    return ActionChip(
      avatar: isSelected ? const Icon(Icons.check) : const Icon(Icons.remove),
      label: Text(category.name),
      backgroundColor: isSelected ? Colors.green[200] : Colors.deepPurple[50],
      shape: const StadiumBorder(),
      onPressed: () => filterState?.onPressedCategory(category),
    );
  }
}

/// Список категорий
class _CategoryList extends StatelessWidget {
  final List<CategoryTypeEntity> userCategories;

  const _CategoryList({
    Key? key,
    required this.userCategories,
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
              isSelected: userCategories.contains(e),
            ),
          )
          .toList(),
    );
  }
}

/// Кнопка Очистить фильтр
class _ClearButton extends StatelessWidget {
  const _ClearButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterState = context.findAncestorStateOfType<_FilterPageState>();

    return IconButton.outlined(
      onPressed: filterState?.clearFilter,
      icon: const Icon(Icons.clear),
    );
  }
}

/// Кнопка Сохранить фильтр
class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterState = context.findAncestorStateOfType<_FilterPageState>();

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FilledButton(
          onPressed: filterState!._userCategories.isEmpty ? null : filterState.saveFilter,
          child: const Text('Сохранить'),
        ),
      ),
    );
  }
}
