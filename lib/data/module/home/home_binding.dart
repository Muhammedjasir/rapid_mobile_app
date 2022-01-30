import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/api/api_client.dart';
import 'package:rapid_mobile_app/data/module/Calendar/calendar_controller.dart';
import 'package:rapid_mobile_app/data/module/charts/chart_controller.dart';
import 'package:rapid_mobile_app/data/module/dashboard/dashboard_controller.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiClient());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => ChartController());
    Get.lazyPut(() => CalendarController());
  }
}
