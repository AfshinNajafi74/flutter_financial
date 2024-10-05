import 'package:floor/floor.dart';
import 'package:income_expenditure/model/transaction_model/transaction_model.dart';

@dao
abstract class TransactionModelDao{
  @Query('SELECT * FROM TransactionModel')
  Future<List<TransactionModel>> getAllTransactionModel();

  @Query('SELECT * FROM TransactionModel WHERE transaction = :transaction')
  Future<TransactionModel?> findTransactionModelByName(String transaction);

  @insert
  Future<void> insertTransactionModel(TransactionModel transactionModel);

  @Query('DELETE FROM TransactionModel WHERE id = :id')
  Future<void> deleteTransactionModelByName(int id);
}