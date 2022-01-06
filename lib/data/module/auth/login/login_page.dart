import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/auth/login/login_controller.dart';
import 'package:rapid_mobile_app/data/widget/buttons_widget/login_button_widget.dart';
import 'package:rapid_mobile_app/data/widget/container_widget/background_widget.dart';
import 'package:rapid_mobile_app/data/widget/container_widget/login_container_widget.dart';
import 'package:rapid_mobile_app/data/widget/text_widget/text_widget.dart';
import 'package:rapid_mobile_app/data/widget/textfields_widget/login_textfield_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWidget(
        userNameController: controller.userNameController,
        passwordController: controller.passwordController,
      ),
    );
  }
}

class LoginWidget extends GetView<LoginController> {
  const LoginWidget(
      {Key? key,
      required TextEditingController userNameController,
      required TextEditingController passwordController})
      : _usernameController = userNameController,
        _passwordController = passwordController,
        super(key: key);

  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  // base url from intent
  get baseUrl => Get.arguments[Strings.kBaseUrl];

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      alignment: Alignment.center,
      childWidget: LoginContainerWidget(
        childWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                bottom: 45,
              ),
              child: TextWidget(
                text: Strings.kLoginTitle.tr,
                textSize: 22,
                textColor: colours.text_color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              child: LoginTextFieldWidget(
                hint: Strings.kUserName,
                controller: _usernameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 45,
              ),
              child: LoginTextFieldWidget(
                hint: Strings.kPassword,
                controller: _passwordController,
              ),
            ),
            LoginButtonWidget(
              label: Strings.kLogin,
              onTap: _onTapButton,
            ),
            SizedBox.fromSize(
              size: const Size(45, 35),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapButton() {
    if (controller.isLoginCredentialsValid()) {
      final result = controller.logIn();
      log('responseBody3: $result');
    }
  }
}
