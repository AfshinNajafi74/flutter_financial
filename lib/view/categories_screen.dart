import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expenditure/controller/add_edit_category_controller.dart';
import 'package:income_expenditure/core/widgets/animated_list_wrapper.dart';
import 'package:income_expenditure/model/category_model/category_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  AddEditCategoryController categoryController = Get.find<AddEditCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("دسته ها"),),
      body: GetBuilder<AddEditCategoryController>(
        init: categoryController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FutureBuilder(
              future: categoryController.fetchCategories(),
              builder: (context, snapshot) {
                List<CategoryModel> data = snapshot.data != null ? snapshot.data as List<CategoryModel> : [];
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.green,));
                } else if (data.isNotEmpty && snapshot.data != null){
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      CategoryModel category = data[index];
                      return AnimatedListWrapper(
                        index: index,
                        child: Card(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      category.typeCategory == TypeCategory.payment
                                          ? Icons.keyboard_arrow_down_rounded
                                          : Icons.keyboard_arrow_up_rounded,
                                      color: category.typeCategory == TypeCategory.payment
                                          ? Colors.red
                                          : Colors.green,
                                      size: 32,
                                    ),
                                    Text(category.name)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(CupertinoIcons.delete),
                                      onPressed: () {
                                        categoryController.removeCategory(category.id!);
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("no data",),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
