import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:income_expenditure/controller/add_edit_category_controller.dart';
import 'package:income_expenditure/controller/add_edit_transaction_controller.dart';
import 'package:income_expenditure/core/constant/extensions.dart';
import 'package:income_expenditure/core/route/name_route.dart';
import 'package:income_expenditure/core/widgets/snack_bar_widget.dart';
import 'package:income_expenditure/generated/l10n.dart';
import 'package:income_expenditure/model/category_model/category_model.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  AddEditTransactionController transactionController = Get.find<AddEditTransactionController>();
  AddEditCategoryController categoryController = Get.find<AddEditCategoryController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        children: [
          GetBuilder<AddEditTransactionController>(
            init: AddEditTransactionController(),
            builder: (controller) {
              return CupertinoSlidingSegmentedControl(
                onValueChanged: (type) {
                  controller.setTypeCategory(type!);
                },
                groupValue: controller.selectedCategoryType,
                children: {TypeCategory.receipt: Text("دریافتی"), TypeCategory.payment: Text("پرداختی")},
              );
            },
          ),
          SizedBox(height: 16),
          GetBuilder<AddEditTransactionController>(
            init: transactionController,
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  transactionController.datePick(context);
                },
                child: Container(
                  width: size.width,
                  height: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.green, width: 2)),
                  child: Row(
                    children: [
                      Container(height: double.infinity, width: 40, decoration: BoxDecoration(color: Color(0xff070675), borderRadius: BorderRadius.circular(7)), child: Icon(Icons.calendar_month_outlined)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(transactionController.dateTime.showDate(context)),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 12),
          GetBuilder<AddEditTransactionController>(
            init: transactionController,
            builder: (controller) {
              return DropdownMenu(
                  errorText: controller.isCategorySelected ? null : "لطفا دسته ای مورد نظر انتخاب کنید",
                  controller: controller.categoryController,
                  inputDecorationTheme: InputDecorationTheme(
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: controller.isCategorySelected ? Colors.grey : Colors.red, // Change border color based on selection
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: controller.isCategorySelected ? Colors.grey : Colors.red, // Change border color based on selection
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: controller.isCategorySelected ? Colors.green : Colors.red, // Red when not selected
                      ),
                    ),
                  ),
                  width: size.width,
                  hintText: "دسته بندی",
                  onSelected: (value) {
                    controller.category = value;
                  },
                  dropdownMenuEntries: List.generate(
                    categoryController.categories.length,
                    (index) {
                      CategoryModel categor = categoryController.categories[index];
                      return DropdownMenuEntry(value: categor.name, label: categor.name);
                    },
                  ));
            },
          ),
          SizedBox(
            height: 12,
          ),
          Form(
            key: transactionController.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: transactionController.amountController,
                  keyboardType: TextInputType.number,
                  textAlign: Localizations.localeOf(context).languageCode == "fa" ? TextAlign.right : TextAlign.left,
                  textDirection: Localizations.localeOf(context).languageCode == "fa" ? TextDirection.rtl : TextDirection.ltr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsSeparatorInputFormatter(),
                  ],
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
                      hintText: "amount"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: transactionController.descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      hintText: "desciption"),
                ),
              ],
            ),
          ),
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
                  backgroundColor: WidgetStatePropertyAll(Color(0xff070675)),
                ),
                onPressed: () {
                  transactionController.validateCategoary();
                  if (transactionController.formKey.currentState!.validate()) {
                    transactionController.submitTransaction();
                    SnackBarWidget().show(context);
                    Get.offAllNamed(
                      NameRoute.transactionsScreen,
                      predicate: (route) {
                        return route.settings.name == NameRoute.mainScreen;
                      },
                    );
                  }
                },
                child: Text(
                  S.of(context).submit,
                  style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
                )),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
