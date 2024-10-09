import 'package:floor/floor.dart';

@entity
class CategoryModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;
  final TypeCategory typeCategory;

  CategoryModel({
    this.id,
    required this.name,
    required this.typeCategory,
  });
}

enum TypeCategory {
  payment,
  receipt,
}
