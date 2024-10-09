import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expenditure/controller/add_edit_category_controller.dart';
import 'package:income_expenditure/core/route/name_route.dart';
import 'package:income_expenditure/core/widgets/snack_bar_widget.dart';
import 'package:income_expenditure/model/category_model/category_model.dart';

class AddCategoryScreen extends StatelessWidget {
  AddCategoryScreen({super.key});

  final AddEditCategoryController categoryController = Get.find<AddEditCategoryController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            GetBuilder<AddEditCategoryController>(
              init: AddEditCategoryController(),
              builder: (controller) {
                return CupertinoSlidingSegmentedControl(
                  onValueChanged: (type) {
                    controller.setTypeCategory(type!);
                  },
                  groupValue: controller.selectedCategoryType,
                  children: {
                    TypeCategory.receipt: Text("دریافتی"),
                    TypeCategory.payment: Text("پرداختی"),
                  },
                );
              },
            ),
            SizedBox(height: 16),
            Form(
                key: categoryController.formKey,
                child: TextFormField(
                  controller: categoryController.categoryNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      hintText: "نام دسته"),
                )),
            const Spacer(),
            SizedBox(
              width: size.width,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Color(0xff070675),
                    ),
                  ),
                  onPressed: () {
                    if (categoryController.formKey.currentState!.validate()) {
                      categoryController.submitCategory();
                      SnackBarWidget().show(context);
                      Get.offAllNamed(
                        NameRoute.categoriesScreen,
                        predicate: (route) {
                          return route.settings.name == NameRoute.mainScreen;
                        },
                      );
                    }
                  },
                  child: Text(
                    "ثـبـت",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  )),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
