import 'package:flutter/material.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/entity/category_type_entity.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/entity/search_filter_entity.dart';

class FilterProvider extends ChangeNotifier {
  SearchFilterEntity get filter => _filter;

  late SearchFilterEntity _filter;

  List<CategoryTypeEntity> get selectedCategories => _selectedCategories;

  final List<CategoryTypeEntity> _selectedCategories = [];

  FilterProvider(this._filter) {
    _selectedCategories.addAll(_filter.categories);
  }

  /// Сохранить фильтр с новыми категориями
  void saveFilter() {
    _filter = SearchFilterEntity(List<CategoryTypeEntity>.from(_selectedCategories));

    notifyListeners();
  }

  /// Обработка нажатия на категорию
  void updateCategory(CategoryTypeEntity category) {
    final isSelected = _selectedCategories.contains(category);

    if (isSelected) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }

    notifyListeners();
  }

  /// Сбросить выбор всех категорий
  void clearFilter() {
    _selectedCategories.clear();

    notifyListeners();
  }

  /// Сбросить выбранные категории до сохранённого значения
  void resetFilter() {
    _selectedCategories
      ..clear()
      ..addAll(List<CategoryTypeEntity>.from(_filter.categories));

    notifyListeners();
  }
}
