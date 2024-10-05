import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expenditure/core/route/name_route.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(NameRoute.categoriesScreen);
                    },
                    child: Container(
                      height: 75,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: CupertinoColors.activeBlue
                      ),
                      child: const Text(" دسته بندی ها",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(NameRoute.transactionsScreen);
                    },
                    child: Container(
                      height: 75,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: CupertinoColors.activeBlue
                      ),
                      child: const Text("تراکنش ها",style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
