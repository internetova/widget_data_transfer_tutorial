import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/entity/category_type_entity.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/providers/filter_provider.dart';

/// Экран фильтра
///
/// Пример с доступом через провайдер
class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const _BackButton(),
        title: const Text('Настройки фильтра'),
        actions: const [
          _ClearButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Consumer<FilterProvider>(
          builder: (_, filterProvider, __) {
            final selectedCategories = filterProvider.selectedCategories;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CategoryList(userCategories: selectedCategories),
                _SaveButton(canSave: selectedCategories.isNotEmpty),
              ],
            );
          },
        ),
      ),
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
    final filterProvider = context.read<FilterProvider>();

    return ActionChip(
      avatar: isSelected ? const Icon(Icons.check) : const Icon(Icons.remove),
      label: Text(category.name),
      backgroundColor: isSelected ? Colors.green[200] : Colors.deepPurple[50],
      shape: const StadiumBorder(),
      onPressed: () => filterProvider.updateCategory(category),
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
    final userCategories = context.read<FilterProvider>().selectedCategories;

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
class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterProvider = context.read<FilterProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () {
          filterProvider.resetFilter();
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}

/// Кнопка Очистить фильтр
class _ClearButton extends StatelessWidget {
  const _ClearButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterProvider = context.read<FilterProvider>();

    return IconButton.outlined(
      onPressed: filterProvider.clearFilter,
      icon: const Icon(Icons.clear),
    );
  }
}

/// Кнопка Сохранить фильтр
class _SaveButton extends StatelessWidget {
  final bool canSave;

  const _SaveButton({
    Key? key,
    required this.canSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterProvider = context.read<FilterProvider>();

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FilledButton(
          onPressed: canSave
              ? () {
                  filterProvider.saveFilter();
                  Navigator.pop(context);
                }
              : null,
          child: const Text('Сохранить'),
        ),
      ),
    );
  }
}
