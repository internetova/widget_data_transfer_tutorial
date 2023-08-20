import 'package:widget_data_transfer_tutorial/features/search_filter/entity/category_type_entity.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/entity/search_filter_entity.dart';

/// Моковые данные для примера
class MockData {
  /// Дефолтные настройки фильтра
  static const searchFilter = SearchFilterEntity([
    CategoryTypeEntity.museum,
    CategoryTypeEntity.park,
  ]);
}
