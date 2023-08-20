import 'package:widget_data_transfer_tutorial/features/search_filter/entity/category_type_entity.dart';

/// Сущность фильтр
///
/// Предназначена для передачи данных между экранами
/// Сейчас у фильтра есть только категории, но на практике тут могут быть и другие настройки
class SearchFilterEntity {
  final List<CategoryTypeEntity> categories;

  const SearchFilterEntity(this.categories);
}