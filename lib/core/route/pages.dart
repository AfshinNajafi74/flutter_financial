import 'package:get/get.dart';
import 'package:income_expenditure/core/route/name_route.dart';
import 'package:income_expenditure/view/add_category_screen.dart';
import 'package:income_expenditure/view/add_edit_transaction_screen.dart';
import 'package:income_expenditure/view/add_transaction_screen.dart';
import 'package:income_expenditure/view/categories_screen.dart';
import 'package:income_expenditure/view/home_screen.dart';
import 'package:income_expenditure/view/main_screen.dart';
import 'package:income_expenditure/view/profile_screen.dart';
import 'package:income_expenditure/view/transactions_screen.dart';

class AppPage {
  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: NameRoute.mainScreen,
      page: () => MainScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: NameRoute.mainScreen,
      page: () => const HomeScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: NameRoute.mainScreen,
      page: () => const ProfileScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: NameRoute.addEditTransactionScreen,
      page: () => const AddEditTransactionScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: NameRoute.categoriesScreen,
      page: () => const CategoriesScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: NameRoute.transactionsScreen,
      page: () => const TransactionsScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: NameRoute.addTransactionScreen,
      page: () => const AddTransactionScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: NameRoute.addCategoryScreen,
      page: () => AddCategoryScreen(),
      transition: Transition.fade,
    )
  ];
}
