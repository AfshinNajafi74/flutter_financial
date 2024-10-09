import 'package:get/get.dart';
import 'package:income_expenditure/controller/add_edit_category_controller.dart';
import 'package:income_expenditure/controller/add_edit_transaction_controller.dart';
import 'package:income_expenditure/controller/data_base_controller.dart';
import 'package:income_expenditure/controller/main_controller.dart';
import 'package:income_expenditure/data_source/locale/database.dart';

class AppBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    final database = await $FloorTransactionModelDatabase.databaseBuilder('transactionModel_database.db').build();

    Get.put(database);
    Get.put<DataBaseController>(DataBaseController());
    Get.put<MainController>(MainController());
    Get.put<AddEditTransactionController>(AddEditTransactionController());
    Get.put<AddEditCategoryController>(AddEditCategoryController());
  }
}
