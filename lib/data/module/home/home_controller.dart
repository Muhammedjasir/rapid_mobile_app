import 'package:get/get.dart';
import 'package:rapid_mobile_app/res/utils/rapid_controller.dart';

class HomeController extends RapidController {
  DateTime? currentBackPressTime;

  RxInt tabIndex = RxInt(0);
}
