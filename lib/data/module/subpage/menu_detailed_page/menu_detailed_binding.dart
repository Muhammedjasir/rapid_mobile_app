import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/subpage/menu_detailed_page/menu_detailed_controller.dart';

class MenuDetailedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MenuDetailedController(),
    );
  }
}
