import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/api/base_service.dart';
import 'package:rapid_mobile_app/data/model/base/rapid_response.dart';
import 'package:rapid_mobile_app/data/model/login_response.dart';

class ApiProvider extends BaseService {
  // for get requests
  // Future<RapidResponse> getApiProvider() async {
  //   var res;
  //   try {
  //     res = await get("person_url");
  //     print(res);
  //     return RapidResponse.fromJson(res.body);
  //   } catch (e) {
  //     var error = errorHandler(res);
  //     print(error.toString());
  //   }
  // }
  //
  // // for post requests
  // Future<RapidResponse> postApiProvider(dynamic body) async {
  //   var res;
  //   try {
  //     res = await post("url", body);
  //     print(res);
  //     return RapidResponse.fromJson(res.body);
  //   } catch (e) {
  //     var error = errorHandler(res);
  //     print(error.toString());
  //   }
  // }

  // for post requests
  Future<LoginResponse> login(String username, String password) async {
    final response = await post<LoginResponse>("url", {
      'username': username,
      'password': password,
    }, decoder: LoginResponse.fromJson);
    print(response);

    var loginResponse = response.body;
    if (response.isOk && loginResponse != null) {
      return loginResponse;
    } else {
      return LoginResponse(
          status: response.status.code, message: response.statusText);
    }
  }

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
