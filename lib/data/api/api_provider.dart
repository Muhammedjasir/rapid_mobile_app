import 'dart:developer';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/model/base/base_response.dart';

class ApiProvider extends GetConnect {
  void updateBaseUrl(String newBaseUrl) {
    httpClient.baseUrl = newBaseUrl;
  }

  Future<BaseResponse> executeRequest({
    String url = '',
    required String method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    var response = await request<dynamic>(
      url,
      method,
      body: body,
      headers: headers,
    );

    log('${response.request?.url}');
    log('Body: $body');
    log('Response: ${response.bodyString}');

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

// for login requests
// Future<dynamic> getLogin(String username, String password) async {
//   dynamic body = {
//     'username': username,
//     'encryppassword': password,
//   };
//
//   final finalBody = json.encode(body);
//
//   debugPrint('body: $body');
//
//   // Map<String, String>? headers = {  'Content-Type': 'application/x-www-form-urlencoded',
//   //   "Authorization":"$token",},
//   final response =
//       await post("https://api.techlogica.com/atmbharath/api/", finalBody);
//
//   debugPrint('response:' + response.request.toString());
//   var responseBody = response.body.toString();
//   if (response.isOk) {
//     // debugPrint('responseBody: $responseBody');
//
//     final respBody = json.decode(responseBody);
//
//     return respBody;
//   } else {
//     debugPrint('response.status.message: ' +
//         response.status.code.toString() +
//         " " +
//         response.statusText.toString());
//   }
// }

// // for put requests
// Future<RapidResponse> putApiProvider(dynamic body) async {
//   var res;
//   try {
//     res = await put("person_url", body);
//     print(res);
//     return RapidResponse.fromJson(res.body);
//   } catch (e) {
//     var error = errorHandler(res);
//     print(error.toString());
//   }
// }
//
// // for delete requests
// Future<RapidResponse> deleteApiProvider() async {
//   var res;
//   try {
//     res = await delete("person_url");
//     print(res);
//     return RapidResponse.fromJson(res.body);
//   } catch (e) {
//     var error = errorHandler(res);
//     print(error.toString());
//   }
// }
//
// dynamic errorHandler(Response response) {
//   print(response.toString());
//   switch (response.statusCode) {
//     case 200:
//       var responseJson = response.body.toString();
//       return responseJson;
//     case 500:
//       throw 'Server Error please retry later';
//     case 403:
//       throw 'Error occurred please check internet and retry';
//     default:
//       throw 'Error occurred retry';
//   }
// }
}
