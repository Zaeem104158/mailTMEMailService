import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stitbd_task/controller/user_controller.dart';
import 'package:stitbd_task/utils/constants.dart';
import 'package:stitbd_task/utils/shared_pref.dart';

import 'package:stitbd_task/utils/size_config.dart';
import 'package:stitbd_task/utils/style.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    final userController = Get.put(UserController());
    userController.getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.all(20),
        width: SizeConfig.getScreenWidth(context) - 20,
        height: 150,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  kPrimaryColor,
                  kErrorColor,
                ])),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: SizeConfig.getScreenWidth(context) - 30,
            height: 140,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  Obx(
                    () => ListTile(
                      title: Text(controller.userEmail.value ?? ""),
                      leading: const Icon(Icons.email),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await SharedPref.remove("keyJwtToken");
                      Get.offAll(() => const LoginScreen(),
                          transition: sendTransition);
                    },
                    child: const ListTile(
                      title: Text("Logout"),
                      leading: Icon(Icons.logout),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
