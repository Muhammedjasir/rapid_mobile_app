
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/auth/project_connection/connection_contoller.dart';

class ConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConnectionController());
  }
}