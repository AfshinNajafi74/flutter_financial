import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:income_expenditure/core/route/name_route.dart';
import 'package:income_expenditure/core/route/pages.dart';
import 'package:income_expenditure/generated/l10n.dart';

class FinancialApp extends StatelessWidget {
  const FinancialApp({super.key});

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
