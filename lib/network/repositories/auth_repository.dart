import 'package:stitbd_task/models/signup_response.dart';

import '../../models/common_responses/common/common_response.dart';
import '../../models/login_response.dart';
import '../../utils/constants.dart';
import '../../utils/endpoints.dart';
import '../api_client.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient.apiClient;
  static final AuthRepository _authRepository = AuthRepository._internal();

  AuthRepository._internal();

  factory AuthRepository() {
    return _authRepository;
  }

  void login(Map<String, dynamic> request,
      ResponseCallback<LoginResponse?, String?> callback) {
    _apiClient.postRequest(loginEndpoint, request, (response, error) {
      if (response != null) {
        callback(LoginResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }

  void signUp(Map<String, dynamic> request,
      ResponseCallback<SignUpResponse?, String?> callback) {
    _apiClient.postRequest(signupEndpoint, request, (response, error) {
      if (response != null) {
        callback(SignUpResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }
}
