import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expenditure/controller/main_controller.dart';
import 'package:income_expenditure/core/route/name_route.dart';
import 'package:income_expenditure/view/home_screen.dart';
import 'package:income_expenditure/view/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  MainController controller = Get.find<MainController>();

  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("data"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Stack(
          children: [
            Positioned.fill(
                child: IndexedStack(
              index: controller.selectedScreen.value,
              children: const [
                HomeScreen(),
                ProfileScreen(),
              ],
            ))
          ],
        ),
        floatingActionButton: SizedBox(
          width: 50,
          height: 50,
          child: Container(
            alignment: Alignment.topCenter,
            color: Colors.transparent,
            child: SizedBox(
              width: 50,
              height: 50,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn)),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        CupertinoColors.activeBlue,
                        CupertinoColors.systemGrey6,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: CupertinoColors.activeBlue.withOpacity(0.4),
                        offset: const Offset(0.0, 16.0),
                        blurRadius: 16.0,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.white.withOpacity(0.1),
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () {
                        Get.toNamed(
                          NameRoute.addEditTransactionScreen,
                        );
                      },
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 8,
          height: kToolbarHeight,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          shape: const CircularNotchedRectangle(),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.selectedScreen.value = 0;
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                    ),
                    Text("home"),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  controller.selectedScreen.value = 1;
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person),
                    Text("profile"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
