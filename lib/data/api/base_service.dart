import 'package:get/get.dart';
import 'package:rapid_mobile_app/res/utils/local_storage.dart';

class BaseService extends GetConnect {

  BaseService(){
    // Move the code here.
  }

  @override
  void onInit() {
    // add your local storage here to load for every request
    var token = LocalStorage.readToken;

    // base_url
    httpClient.baseUrl = LocalStorage.baseUrl;

    httpClient.defaultContentType = "application/json";
    // httpClient.timeout = Duration(seconds: 8);

    // headers
    var headers = {'Authorization': "Bearer $token"};
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers.addAll(headers);
      return request;
    });

    httpClient.addRequestModifier<dynamic>((request) async {
      // add request here
      print(request.url);
      print(request.method);
      print(request.decoder);
      print(request.headers);
      return request;
    });

    httpClient.addResponseModifier<dynamic>((request, response) async {
      // response body
      print(request.url);
      print(request.method);
      print(response.body);
      print(response.status.code);
    });

    super.onInit();
  }
}
