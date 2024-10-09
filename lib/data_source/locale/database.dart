import 'dart:async';
import 'package:floor/floor.dart';
import 'package:income_expenditure/model/category_model/category_model.dart';
import 'package:income_expenditure/data_source/locale/category_model_dao.dart';
import 'package:income_expenditure/model/transaction_model/transaction_model.dart';
import 'package:income_expenditure/data_source/locale/transaction_model_dao.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [TransactionModel, CategoryModel])
abstract class TransactionModelDatabase extends FloorDatabase {
  TransactionModelDao get transactionModelDao;

  CategoryModelDao get categoryModelDao;
}
