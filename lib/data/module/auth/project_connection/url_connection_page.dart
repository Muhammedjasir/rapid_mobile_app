import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/api/api_client.dart';
import 'package:rapid_mobile_app/data/module/auth/project_connection/connection_contoller.dart';
import 'package:rapid_mobile_app/data/widget/container_widget/background_widget.dart';
import 'package:rapid_mobile_app/data/widget/buttons_widget/login_button_widget.dart';
import 'package:rapid_mobile_app/data/widget/container_widget/login_container_widget.dart';
import 'package:rapid_mobile_app/data/widget/textfields_widget/login_textfield_widget.dart';
import 'package:rapid_mobile_app/res/utils/rapid_pref.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class UrlConnectionPage extends GetView<ConnectionController> {
  const UrlConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        alignment: Alignment.center,
        childWidget: LoginContainerWidget(
          childWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: LoginTextFieldWidget(
                  hint: Strings.kUrl.tr,
                  controller: controller.baseUrlControllerUrl,
                ),
              ),
              LoginButtonWidget(
                label: Strings.kContinue.tr,
                onTap: _onTapButton,
              ),
              SizedBox.fromSize(
                size: const Size(45, 35),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onTapButton() {
    if (controller.isBaseUrlCredentialValid()) {
      RapidPref().setBaseUrl(controller.baseUrlControllerUrl.text);
      Get.find<ApiClient>().updateBaseUrl(controller.baseUrlControllerUrl.text);
      Get.toNamed(
        Strings.kLoginPage,
      );
    }
  }
}
