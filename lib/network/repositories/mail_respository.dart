import 'package:stitbd_task/models/mail_response.dart';

import 'package:stitbd_task/utils/constants.dart';

import '../api_client.dart';

class MailRepository {
  final ApiClient _apiClient = ApiClient.apiClient;
  static final MailRepository _mailRepository = MailRepository._internal();

  MailRepository._internal();

  factory MailRepository() {
    return _mailRepository;
  }

  //Get mail repository
  void getMailAPI(
      String url, ResponseCallback<UserMailResponse?, String?> callback) {
    _apiClient.getRequest(url, (response, error) {
      if (response != null) {
        callback(UserMailResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }
}
