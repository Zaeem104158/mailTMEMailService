import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stitbd_task/components/no_datafound_card_component.dart';
import 'package:stitbd_task/components/text_component.dart';
import 'package:stitbd_task/controller/mail_controller.dart';
import 'package:stitbd_task/utils/size_config.dart';
import 'package:stitbd_task/utils/style.dart';

class MailScreen extends StatefulWidget {
  const MailScreen({super.key});

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  @override
  void initState() {
    final mailController = Get.put(MailController());
    mailController.getMail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MailController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.all(20),
        width: SizeConfig.getScreenWidth(context) - 20,
        height: SizeConfig.getScreenHeight(context) - 20,
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
            height: SizeConfig.getScreenHeight(context) - 30,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Obx(()=>controller.totalItems.value != null
                  ? ListView.separated(
                itemCount: controller.totalItems.value!,
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: kPrimaryColor,
                    thickness: 2,
                  );
                },
                itemBuilder: (context, index) {
                  var mails = controller.mails[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.primaries[
                      Random().nextInt(Colors.primaries.length)],
                      child: TextComponent(
                        _getInitials(
                          mails.from.name,
                        ),
                        padding: const EdgeInsets.all(4),
                        fontSize: 10,
                      ),
                    ),
                    title: Row(
                      children: [
                        TextComponent(
                          padding: const EdgeInsets.all(4),
                          mails.from.name,
                          fontSize: 10,
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.email),
                            const SizedBox(
                              width: 10,
                            ),
                            TextComponent(
                              mails.from.address,
                              fontSize: 10,
                              padding: const EdgeInsets.all(4),
                            ),
                          ],
                        ),
                        TextComponent(
                          "Subject: ${mails.subject}",
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          padding: const EdgeInsets.all(4),
                        ),
                        TextComponent(
                          "Mail: ${mails.intro}",
                          fontSize: 10,
                          padding: const EdgeInsets.all(4),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  );
                },
              )
                  : NoDataFoundCard(
                onPressed: () {
                  final mailController = Get.put(MailController());
                  mailController.getMail();
                  setState(() {});
                },
                title: "No data found yet",
                searchKey: "Reload",
              ),)
            ),
          ),
        ),
      );
    });
  }

  String _getInitials(String user) {
    String name = "";
    name = user;
    var buffer = StringBuffer();
    var split = user.trim().split(" ");
    if (split.length > 1) {
      for (var s in split) {
        buffer.write(s[0]);
      }
      name = buffer.toString().substring(0, split.length);
      name.capitalize;
    } else {
      split = user.trim().split("");
      name = "${split[0].capitalize}${split[1].capitalize}";
    }
    return name;
  }
}
