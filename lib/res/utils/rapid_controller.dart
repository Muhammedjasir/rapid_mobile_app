import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/api/api_provider.dart';

mixin RapidController{
  ApiProvider get apiClient => Get.find<ApiProvider>();

  void updateBaseUrl(String newBaseUrl){
    apiClient.updateBaseUrl(newBaseUrl);
  }
}