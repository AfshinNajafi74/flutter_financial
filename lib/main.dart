import 'package:flutter/material.dart';
import 'package:income_expenditure/bindings/bindings.dart';
import 'package:income_expenditure/financial_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppBindings mainBinding = AppBindings();
  await mainBinding.dependencies();

  runApp(FinancialApp());
}
