import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/api/http_method.dart';
import 'package:rapid_mobile_app/data/model/base/base_response.dart';
import 'package:rapid_mobile_app/res/utils/rapid_controller.dart';

class LoginController extends GetxController with RapidController {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Rxn<BaseResponse> data = Rxn();

  Future<BaseResponse> logIn() async {
    dynamic body = {
      'username': userNameController.text,
      'encryppassword': passwordController.text,
    };

    updateBaseUrl('https://api.techlogica.com/atmbharath/api/');

    BaseResponse result = await apiClient.executeRequest(
      method: HttpMethod.POST,
      body: body,
    );
    // log('responseBody3: ${result.data['token']}');
    data.value = result;
    return result;
  }

  /// Returns true: if the username and password matches the validation criteria
  bool isLoginCredentialsValid() {
    return userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}
