import 'package:get/get.dart';
import 'package:income_expenditure/data_source/locale/database.dart';
import 'package:income_expenditure/model/category_model/category_model.dart';
import 'package:income_expenditure/model/transaction_model/transaction_model.dart';

class DataBaseController extends GetxController {
  final _fetchTransactionData = Get.find<TransactionModelDatabase>().transactionModelDao;
  final _fetchCategoryData = Get.find<TransactionModelDatabase>().categoryModelDao;

  // Transaction insert
  void insertTransaction(TransactionModel transactionModel) async {
    _fetchTransactionData.insertTransactionModel(transactionModel);
  }

  // Get all transactions
  Future<List<TransactionModel>> getAllTransactions() async {
    return _fetchTransactionData.getAllTransactionModel();
  }

  // Transaction delete
  void deleteTransaction(int id) async {
    _fetchTransactionData.deleteTransactionModelByName(id);
  }

  // Transaction search
  Future<TransactionModel?> findTransactionByName(String transaction) {
    return _fetchTransactionData.findTransactionModelByName(transaction);
  }

  // Category insert
  void insertCategory(CategoryModel categoryModel) async {
    _fetchCategoryData.insertCategoryModel(categoryModel);
  }

  // Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    return _fetchCategoryData.getAllCategoryModel();
  }

  // Category delete
  void deleteCategory(int id) async {
    _fetchCategoryData.deleteCategoryModelByName(id);
  }
}
