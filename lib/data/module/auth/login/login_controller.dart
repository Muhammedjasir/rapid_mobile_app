import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/api/http_method.dart';
import 'package:rapid_mobile_app/data/model/base/base_response.dart';
import 'package:rapid_mobile_app/res/utils/generate_random_string.dart';
import 'package:rapid_mobile_app/res/utils/rapid_controller.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class LoginController extends RapidController {
  final TextEditingController userNameController = TextEditingController(text: "TESTER");
  final TextEditingController passwordController = TextEditingController(text: "QWERTYUIOP");

  Rxn<BaseResponse> data = Rxn();

  Future<BaseResponse> logIn() async {
    dynamic body = {
      'username': userNameController.text,
      'encryppassword': passwordController.text,
    };

    Map<String, String>? headers = {Strings.kHeaderKey:"$generateRandomString()",};

    BaseResponse result = await apiClient.executeRequest(
      endpoint: '',
      method: HttpMethod.POST,
      body: body,
      headers: headers
    );
    // log('responseBody3: ${result.data['token']}');
    data.value = result;
    return result;
  }

  ///Returns true: if the username and password matches the validation criteria
  bool isLoginCredentialsValid() {
    return userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}
