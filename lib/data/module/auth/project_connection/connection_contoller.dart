import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ConnectionController extends GetxController {
  final TextEditingController baseUrlControllerUrl = TextEditingController(
    text: 'https://api.techlogica.com/atmbharath/api/',
  );

  /// Returns true: if the baseurl matches the validation criteria
  bool isBaseUrlCredentialValid() {
    return baseUrlControllerUrl.text.isNotEmpty;
  }
}
