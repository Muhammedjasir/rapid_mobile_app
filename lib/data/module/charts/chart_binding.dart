import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/charts/chart_controller.dart';

class ChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChartController());
  }
}
