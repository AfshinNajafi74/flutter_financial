import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expenditure/controller/data_base_controller.dart';
import 'package:income_expenditure/model/category_model/category_model.dart';

class AddEditCategoryController extends GetxController {
  DataBaseController dataBaseController = Get.find<DataBaseController>();
  TextEditingController categoryNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<CategoryModel> categories = [];
  TypeCategory selectedCategoryType = TypeCategory.payment;

  void submitCategory() {
    CategoryModel category = CategoryModel(
      name: categoryNameController.text,
      typeCategory: selectedCategoryType,
    );
    dataBaseController.insertCategory(category);
    categoryNameController.clear();
    selectedCategoryType = TypeCategory.payment;
  }

  Future<List<CategoryModel>> fetchCategories() async {
    categories.clear();
    List<CategoryModel> data = await dataBaseController.getAllCategories();
    categories.addAll(data);
    return data;
  }

  void removeCategory(int id) {
    dataBaseController.deleteCategory(id);
    update();
  }

  void setTypeCategory(TypeCategory type) {
    selectedCategoryType = type;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

// @override
// void onClose() {
//   super.onClose();
//   print("oncolsee");
//   categories.clear();
// }
}
