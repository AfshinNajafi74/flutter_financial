import 'package:income_expenditure/model/category_model/category_model.dart';
import 'package:floor/floor.dart';

@entity
class TransactionModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int dateTime;
  final String name;
  final String amount;
  final String? description;
  final TypeCategory typeCategory;

  TransactionModel({
    this.id,
    required this.dateTime,
    required this.name,
    required this.amount,
    required this.typeCategory,
    this.description,
  });
}