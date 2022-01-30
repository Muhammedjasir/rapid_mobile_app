import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/Calendar/calendar_controller.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalendarController());
  }
}
