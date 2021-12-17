import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/auth/login/login_controller.dart';
import 'package:rapid_mobile_app/data/widget/buttons_widget/login_button_widget.dart';
import 'package:rapid_mobile_app/data/widget/container_widget/background_widget.dart';
import 'package:rapid_mobile_app/data/widget/container_widget/login_container_widget.dart';
import 'package:rapid_mobile_app/data/widget/text_widget/text_widget.dart';
import 'package:rapid_mobile_app/data/widget/textfields_widget/login_textfield_widget.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  get baseUrl => Get.arguments[Strings.kBaseUrl];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: LoginWidget(
          userNameController: controller.userNameController,
          passwordController: controller.passwordController),
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
    String userName = controller.userNameController.text.trim();
    String password = controller.passwordController.text.trim();
    if (userName.isNotEmpty && password.isNotEmpty) {
      Get.toNamed(Strings.kdDashboardPage);
    }
  }
}
