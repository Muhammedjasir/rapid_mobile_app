import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/auth/login/login_controller.dart';
import 'package:rapid_mobile_app/data/widget/buttons/login_button_widget.dart';
import 'package:rapid_mobile_app/data/widget/container/background_widget.dart';
import 'package:rapid_mobile_app/data/widget/container/login_container_widget.dart';
import 'package:rapid_mobile_app/data/widget/text/text_widget.dart';
import 'package:rapid_mobile_app/data/widget/textfields/login_text_field_widget.dart';
import 'package:rapid_mobile_app/res/utils/rapid_pref.dart';
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

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
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

  void _onTapButton() async {
    if (controller.isLoginCredentialsValid()) {
      // to get token & project_id
      final result = await controller.logIn();
      // check login API status
      if (result.status == true) {
        RapidPref().changeToken(result.data['token']);
        RapidPref().changeProjectId(result.data['Project_id'].toString());
        RapidPref().changeUserName(controller.userNameController.text);
        RapidPref().changeUserPassword(controller.passwordController.text);
        Get.toNamed(
          Strings.kDashboardPage,
        );
      } else {
        Get.snackbar("Message", result.message);
      }
    }
  }
}
