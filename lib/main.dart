import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:income_expenditure/bindings/bindings.dart';
import 'package:income_expenditure/core/route/name_route.dart';
import 'package:income_expenditure/core/route/pages.dart';
import 'package:income_expenditure/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppBindings mainBinding = AppBindings();
  await mainBinding.dependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),

      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale("fa"),
      initialRoute: NameRoute.mainScreen,
      getPages: AppPage.pages,
    );
  }
}
