import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stitbd_task/network/repositories/user_repository.dart';
import 'package:stitbd_task/utils/constants.dart';
import 'package:stitbd_task/utils/endpoints.dart';
import 'package:stitbd_task/view/dashboard_screen.dart';
import 'package:stitbd_task/view/login_screen.dart';

class UserController extends GetxController {
  late final UserRepository _userRepository;

  var userEmail = Rxn<String?>();

  List<String> contactList = [];

  @override
  void onInit() {
    _userRepository = UserRepository();
    super.onInit();
  }

  //Get user controller.
  void getUserInfo(String? source) {
    _userRepository.getUserMeAPI(getUserMeEndPoint, (response, error) {
      if (response != null) {
        userEmail.value = response.address;
        if (source == "splash") {
          Future.delayed(const Duration(milliseconds: 1000), () {
            Get.offAll(() => const DashBoardScreen(),
                transition: sendTransition);
          });
        }
      } else {
        Get.offAll(() => const LoginScreen(), transition: sendTransition);
      }
    });
  }
}
