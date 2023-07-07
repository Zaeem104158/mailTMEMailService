import 'package:get/get.dart';
import 'package:stitbd_task/models/login_response.dart';

import 'package:stitbd_task/view/dashboard_screen.dart';
import '../network/repositories/auth_repository.dart';
import '../utils/constants.dart';
import '../utils/shared_pref.dart';

class AuthController extends GetxController {
  late final AuthRepository _authRepository;

  @override
  void onInit() {
    _authRepository = AuthRepository();
    super.onInit();
  }

  final loginEmailObs = Rxn<String?>();
  final loginPasswordObs = Rxn<String?>();

  final forgotPasswordEmailObs = Rxn<String?>();

  void login() {
    loading();

    var request = {
      "address": loginEmailObs.value,
      "password": loginPasswordObs.value
    };

    _authRepository.login(request, (response, error) {
      dismissLoading();

      if (response != null) {
        _saveJWTTokenLocally(response);
      } else {
        showMessage("Something went wrong: $error");
      }
    });
  }

  Future<void> _saveJWTTokenLocally(LoginResponse? payload) async {
    try {
      var token = payload?.token;

      await SharedPref.write(keyJwtToken, token);

      Get.offAll(() => const DashBoardScreen(), transition: sendTransition);
    } catch (e) {
      showMessage(e.toString());
    }
  }

  // void forgotPassword({bool isResendCode = false}) {
  //   loading();

  //   var request = {"email": forgotPasswordEmailObs.value};

  //   _authRepository.forgotPassword(request, (response, error) async {
  //     if (response != null) {
  //       showMessage("Reset password link has sent to your mail!",
  //           isToast: true);
  //       await Future.delayed(const Duration(seconds: 3));
  //       Get.back();
  //     } else {
  //       showMessage("Invalid Email");
  //     }
  //   });
  // }
}
