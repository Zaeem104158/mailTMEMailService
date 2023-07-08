import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stitbd_task/controller/user_controller.dart';
import 'package:stitbd_task/utils/shared_pref.dart';
import 'package:stitbd_task/view/dashboard_screen.dart';
import 'package:stitbd_task/view/login_screen.dart';

import '../../base/base_state.dart';
import '../../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  startTime() async {
    try {
      var jwt = await SharedPref.read("keyJwtToken");

      final userController = Get.put(UserController());
      userController.getUserInfo();
      if (jwt != null) {
        Get.offAll(() => const DashBoardScreen(), transition: sendTransition);
      } else {
        Get.offAll(() => const LoginScreen(), transition: sendTransition);
      }
    } catch (e) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Get.offAll(() => const LoginScreen(), transition: sendTransition);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    isInternetConnected(context).then((internet) {
      if (internet) {
        // Internet Present Case
        startTime();
      } else {
        // No-Internet Case
        showWarningDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(48.0),
      child: Text("Hello Dev"),
    );
  }

  showWarningDialog(BuildContext context) {
    Widget continueButton = TextButton(
      child: const Text(
        "Retry",
      ),
      onPressed: () {
        Navigator.pop(context);
        EasyLoading.showToast("Please wait...");

        isInternetConnected(context).then((internet) {
          if (internet) {
            // Internet Present Case
            startTime();
          } else {
            // No-Internet Case
            showWarningDialog(context);
          }
        });
      },
    );

    Widget cancelButton = TextButton(
      child: const Text(
        "Exit",
      ),
      onPressed: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
    );

    if (Platform.isIOS) {
      CupertinoAlertDialog alert = CupertinoAlertDialog(
        title: const Text(
          "No Internet connection!",
        ),
        content: const Text(
          "Please Connect your device to internet first",
        ),
        actions: [cancelButton, continueButton],
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      AlertDialog alert = AlertDialog(
        elevation: 2,
        title: const Text(
          "No Internet connection!",
        ),
        content: const Text(
          "Please Connect your device to internet first",
        ),
        actions: [cancelButton, continueButton],
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
