import 'package:stitbd_task/components/text_form_field_component.dart';
import 'package:stitbd_task/controller/auth_controller.dart';
import '../../base/base_state.dart';
import '../../components/button_component.dart';
import '../../components/password_text_form_field_component.dart';
import '../../components/text_component.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../../utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseState<SignUpScreen> {
  late Rxn<String?> email, password;
  final _authController = Get.put(AuthController());
  final textController = TextEditingController();

  bool isMailSuffixVisible = false;
  bool isPwSuffixVisible = false;

  @override
  void initState() {
    email = _authController.loginEmailObs;
    password = _authController.loginPasswordObs;

    super.initState();
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    resetGetXValues([email, password]);
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.getScreenWidth(context),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => closeSoftKeyBoard(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      const TextComponent(
                        'Sign Up',
                        fontWeight: titleFontWeight,
                        fontSize: largestFontSize,
                        color: kTextColor,
                        padding: EdgeInsets.only(top: 64, bottom: 48),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 4.0),
                        child: TextFormFieldComponent(
                          hint: "Enter your email",
                          isEmailValidation: true,
                          textEditingController: textController,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          prefixWidget: const Icon(Icons.email_outlined),
                          suffixWidget: isMailSuffixVisible
                              ? InkWell(
                                  onTap: () {
                                    textController.text = "";
                                    setState(() {
                                      isMailSuffixVisible = false;
                                    });
                                  },
                                  child: const Icon(Icons.cancel_outlined),
                                )
                              : null,
                          inputDecorationBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (String? value) {
                            email.value = value;
                            setState(() {
                              isMailSuffixVisible = true;
                            });
                            if (value != null) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  isMailSuffixVisible = true;
                                });
                              } else {
                                setState(() {
                                  isMailSuffixVisible = false;
                                });
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: PasswordTextFormFieldComponent(
                          hint: "Enter your password",
                          isFullValidate: false,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          inputDecorationBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (String? value) {
                            password.value = value;
                          },
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: const Icon(Icons.visibility_off),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => ButtonComponent(
                          text: "Sign Up",
                          padding: const EdgeInsets.fromLTRB(28, 24, 28, 8),
                          onPressed: isBlank([email.value, password.value])
                              ? null
                              : () {
                                  _authController.signUp();
                                },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
