import 'dart:convert';

import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/model/base/base_response.dart';
import 'package:rapid_mobile_app/data/repository/online/rapid/rapid_repository.dart';
import 'package:rapid_mobile_app/res/utils/rapid_pref.dart';
import 'package:rapid_mobile_app/res/values/logs/logs.dart';

class ApiClient extends GetConnect {
  ApiClient() {
    httpClient.baseUrl = RapidPref().getBaseUrl();
  }

  late RapidRepository rapidRepo = RapidRepository(this);

  void updateBaseUrl(String newBaseUrl) {
    httpClient.baseUrl = newBaseUrl;
  }

  Future<BaseResponse> executeRequest({
    required String endpoint,
    required String method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    var response = await request<dynamic>(
      endpoint,
      method,
      body: json.encode(body),
      headers: headers,
    );

    Logs.logData("url:", response.request?.url);
    Logs.logData("method:", response.request?.method);
    Logs.logData("header:", response.request?.headers);
    Logs.logData("body:", json.encode(body));
    Logs.logData("response:", response.bodyString);

    try {
      final result = BaseResponse.fromJson(response.body);
      return result;
    } catch (error) {
      error.printError();
      final result = BaseResponse(
        status: false,
        message: error.toString(),
        data: null,
      );
      return result;
    }
  }
}
