import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_jalali_date_picker/flutter_jalali_date_picker.dart';
import 'package:income_expenditure/controller/data_base_controller.dart';
import 'package:income_expenditure/model/category_model/category_model.dart';
import 'package:income_expenditure/model/transaction_model/transaction_model.dart';
import 'package:shamsi_date/shamsi_date.dart';

class AddEditTransactionController extends GetxController{
  DataBaseController dataBaseController = Get.find<DataBaseController>();
  TextEditingController amountController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  PageController pageController = PageController();
  bool isCategorySelected = true; // To track if category is selected
  final formKey = GlobalKey<FormState>();
  TypeCategory selectedCategoryType = TypeCategory.payment;

  DateTime dateTime = DateTime.now();
  String? category;

  Future<DateTime?> datePick(BuildContext context) async {
    if(Localizations.localeOf(context).languageCode == "fa") {
      return showJalaliDatePicker(
        context,
        initialDate: Jalali.now(),
        firstDate: Jalali(1385, 8),
        lastDate: Jalali(1450, 9),
      ).then(
        (date) {
          if (date != null) {
            dateTime = date.toDateTime();
          }
          update();
          return;
        },
      );
    } else {
      return showDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2050),
        context: context
      ).then(
        (date) {
          if (date != null) {
            dateTime = date;
          }
          update();
          return;
        },
      );
    }
  }

  submitTransaction () {
    TransactionModel transaction = TransactionModel(
        dateTime: dateTime.millisecondsSinceEpoch,
        name: categoryController.text,
        amount: amountController.text,
        description: descriptionController.text,
        typeCategory: selectedCategoryType
    );
    dataBaseController.insertTransaction(transaction);
  }

  void validateCategoary() {
    if(categoryController.text.isEmpty){
      isCategorySelected = false;
    }else {
      isCategorySelected = true;
    }
    update();
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    List<TransactionModel> data = await dataBaseController.getAllTransactions();
    return data;
  }

  void removeTransaction(int id) {
    dataBaseController.deleteTransaction(id);
    update();
  }

  void setTypeCategory(TypeCategory type) {
    selectedCategoryType = type;
    update();
  }
}