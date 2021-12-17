
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:rapid_mobile_app/data/module/auth/project_connection/connection_contoller.dart';

class ConnectionBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ConnectionController());
  }
}