import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stitbd_task/controller/ui_controller.dart';
import 'package:stitbd_task/utils/style.dart';
import 'package:stitbd_task/view/mail_screen.dart';
import 'package:stitbd_task/view/profile_screen.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});
  final List<Widget> screens = const [
    MailScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final uiController = Get.put(UiController());
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Do you want to exit?'),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Obx(() => Text(
                uiController.bottomNavigationControlSelectedIndex.value == 0
                    ? "Mail Screen"
                    : "Profile Screen")),
          ),
          body: Obx(() =>
              screens[uiController.bottomNavigationControlSelectedIndex.value]),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
                selectedItemColor: kPrimaryColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 16.0,
                unselectedFontSize: 16.0,
                type: BottomNavigationBarType.shifting,
                currentIndex:
                    uiController.bottomNavigationControlSelectedIndex.value,
                onTap: (currentIndex) {
                  uiController
                      .setBottomNavigationControlSelectedIndex(currentIndex);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.mail,
                      ),
                      label: "Mail"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                      ),
                      label: "Profile"),
                ]),
          ),
        ));
  }
}