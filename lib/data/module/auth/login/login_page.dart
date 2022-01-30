import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rapid_mobile_app/data/model/projects_list_model/project_list_response.dart';
import 'package:rapid_mobile_app/data/module/auth/login/login_controller.dart';
import 'package:rapid_mobile_app/data/widget/buttons/login_button_widget.dart';
import 'package:rapid_mobile_app/data/widget/container/background_widget.dart';
import 'package:rapid_mobile_app/data/widget/container/login_container_widget.dart';
import 'package:rapid_mobile_app/data/widget/text/text_widget.dart';
import 'package:rapid_mobile_app/data/widget/text_fields/login_text_field_widget.dart';
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
                text: RapidPref().getProjectName().toString(),
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
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
                obscureText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 45,
              ),
              child: Obx(
                () => LoginTextFieldWidget(
                  hint: Strings.kPassword,
                  controller: _passwordController,
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: controller.isObscure.value,
                  obscureClick: () => controller.obscureToggle(),
                  shouldDisplayEyeIcon: true,
                ),
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

        ProjectListResponse response = ProjectListResponse(
            projectName: controller.argumentData['projectName'],
            projectKey: controller.argumentData['projectKey'],
            projectUrl: controller.argumentData['url'],
            userName: controller.userNameController.text,
            password: controller.passwordController.text,
            projectId: result.data['Project_id'].toString());

        final userBox = await Hive.openBox<ProjectListResponse>(Strings.kRapidMainDatabase);
        userBox.putAt(controller.argumentData['index'], response);

        RapidPref().changeToken(result.data['token']);
        RapidPref().changeProjectId(result.data['Project_id'].toString());
        RapidPref().changeUserName(controller.userNameController.text);
        RapidPref().changeUserPassword(controller.passwordController.text);
        Get.offAllNamed(
          Strings.kHomePage,
        );
      } else {
        Get.snackbar("Message", result.message);
      }
    }
  }
}
