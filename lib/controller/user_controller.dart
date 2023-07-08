import 'package:get/get.dart';
import 'package:stitbd_task/network/repositories/user_repository.dart';

import 'package:stitbd_task/utils/endpoints.dart';

class UserController extends GetxController {
  late final UserRepository _userRepository;
  final userEmail = Rxn<String?>();

  @override
  void onInit() {
    _userRepository = UserRepository();
    super.onInit();
  }

  //Get user controller.
  void getUserInfo() {
    _userRepository.getUserMeAPI(getUserMeEndPoint, (response, error) {
      if (response != null) {
        userEmail.value = response.address;
      } else {}
    });
  }
}
