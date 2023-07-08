import 'package:get/get.dart';
import 'package:stitbd_task/models/mail_response.dart';
import 'package:stitbd_task/network/repositories/mail_respository.dart';
import 'package:stitbd_task/utils/constants.dart';
import 'package:stitbd_task/utils/endpoints.dart';

class MailController extends GetxController {
  late final MailRepository _mailRepository;
  final totalItems = Rxn<int?>();
  final mails = <HydraMember>[].obs;

  @override
  void onInit() {
    _mailRepository = MailRepository();
    super.onInit();
  }

  //Get Mail controller.
  void getMail() {
    _mailRepository.getMailAPI(userMailsEndPoint, (response, error) {
      if (response != null) {
        totalItems.value = response.hydraTotalItems;
        mails.value = response.hydraMember;
      } else {}
    });
  }
}
