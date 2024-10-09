import 'package:floor/floor.dart';
import 'package:income_expenditure/model/category_model/category_model.dart';

@dao
abstract class CategoryModelDao {
  @Query('SELECT * FROM CategoryModel')
  Future<List<CategoryModel>> getAllCategoryModel();

  @insert
  Future<void> insertCategoryModel(CategoryModel categoryModel);

  @Query('DELETE FROM CategoryModel WHERE id = :id')
  Future<void> deleteCategoryModelByName(int id);
}
