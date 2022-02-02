import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/Calendar/calendar_page.dart';
import 'package:rapid_mobile_app/data/module/charts/chart_page.dart';
import 'package:rapid_mobile_app/data/module/dashboard/dashboard_page.dart';
import 'package:rapid_mobile_app/data/module/home/home_controller.dart';
import 'package:rapid_mobile_app/data/widget/app_bar/app_bar_widget.dart';
import 'package:rapid_mobile_app/data/widget/bottom_bar/home_bottom_bar_widget.dart';
import 'package:rapid_mobile_app/data/widget/drawer/side_drawer.dart';
import 'package:rapid_mobile_app/res/utils/rapid_pref.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  final tabs = const [Dashboard(), ChartPage(), CalendarPage()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        drawer: const Drawer(
          elevation: 0,
          child: SideDrawer(),
        ),
        appBar: AppBarWidget(
          title: RapidPref().getProjectName().toString(),
          leadingIcon: Icons.menu,
          actionIcon: Icons.search,
          onTapActionIcon: onActionIconTap,
        ),
        bottomNavigationBar: HomeBottomBarWidget(onItemTap: _onItemTap),
        body: Obx(
          () => tabs[controller.tabIndex.value],
        ),
      ),
    );
  }

  onActionIconTap() {
    // Get.toNamed(
    //   Strings.kChartPage,
    // );
  }

  // bottomNavigationBar click events
  void _onItemTap(int index) {
    controller.tabIndex.value = index;
  }

  Future<bool> _onBackPress() async {
    if (controller.currentBackPressTime == null) {
      controller.currentBackPressTime = DateTime.now();
      Get.snackbar("Exit!", "Tap back again to leave");
      return false;
    }
    if (DateTime.now().difference(controller.currentBackPressTime!).inSeconds <
        3) {
      return true;
    } else {
      controller.currentBackPressTime = DateTime.now();
      Get.snackbar("Exit!", "Tap back again to leave");
      return false;
    }
  }
}

// logout alert
onLogout() {
  Get.defaultDialog(
    title: Strings.kLogout,
    middleText: Strings.kLogoutMessage,
    textCancel: Strings.kCancel,
    textConfirm: Strings.kLogout,
    contentPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
    titlePadding: const EdgeInsets.only(top: 25, bottom: 20),
    onCancel: () => Get.back(),
    onConfirm: () {
      RapidPref().eraseContainer();
      Get.offAllNamed(
        Strings.kUrlConnectionPage,
      );
    },
    radius: 10.0,
    barrierDismissible: true,
  );
}
