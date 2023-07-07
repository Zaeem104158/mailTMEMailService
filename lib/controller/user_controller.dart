import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stitbd_task/network/repositories/user_repository.dart';
import 'package:stitbd_task/utils/constants.dart';
import 'package:stitbd_task/utils/endpoints.dart';
import 'package:stitbd_task/view/dashboard_screen.dart';
import 'package:stitbd_task/view/login_screen.dart';

class UserController extends GetxController {
  late final UserRepository _userRepository;
  var userName = Rxn<String?>();
  var userEmail = Rxn<String?>();
  var userPhone = Rxn<String?>();
  var userCompany = Rxn<String?>();

  final editedUserNameController = TextEditingController(text: "");
  final editedUserPhoneController = TextEditingController(text: "");

  var contactName = Rxn<String?>();
  var contactPhone = Rxn<String?>();
  var contactCompany = Rxn<String?>();
  var contactEmail = Rxn<String?>();
  var contactId = Rxn<String?>();

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
        // userName.value = response.name ?? "";
        // userEmail.value = response.email ?? "";
        // userCompany.value = response.organisation?.name;

        // editedUserNameController.text = response.name ?? "";
        // editedUserPhoneController.text = response.phone ?? "";

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

  //Update user controller
  // void updateUserInfo() {
  //   Map<String, dynamic> updateUser = {
  //     "name": editedUserNameController.text,
  //     "phone": editedUserPhoneController.text,
  //   };

  //   _userRepository.updateUserMeAPI(getUserInfoEndPoint, updateUser,
  //       (response, error) {
  //     if (response != null) {
  //       //getUserInfo();
  //       showMessage("Successfully update user", isInfo: true);
  //     } else {
  //       showMessage("Something went wrong");
  //     }
  //   });
  // }

  // void callCreateContact() {
  //   loading();

  //   CreateContactParam _createContactParam = CreateContactParam();

  //   _createContactParam.name = contactName.value;
  //   _createContactParam.email = contactEmail.value;
  //   _createContactParam.phone = contactPhone.value;
  //   _createContactParam.company = contactCompany.value;

  //   if (contactId.value != null) {
  //     contactList.add(contactId.value!);
  //   }

  //   _createContactParam.assignedToUserIds = contactList;

  //   _userRepository.createContactAPI(_createContactParam.toJson(),
  //       (response, error) {
  //     dismissLoading();

  //     if (response != null) {
  //       showMessage("Contact has added successfully", isToast: true);
  //       _createContactParam.assignedToUserIds?.clear();
  //       contactList.clear();
  //     } else {
  //       showMessage("Something went wrong: $error");
  //       _createContactParam.assignedToUserIds?.clear();
  //       contactList.clear();
  //     }
  //   });
  // }
}
