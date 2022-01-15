import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/api/api_client.dart';

abstract class RapidController extends GetxController {
  ApiClient get apiClient => Get.find<ApiClient>();
}
