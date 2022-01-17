import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/dashboard/dashboard_controller.dart';
import 'package:rapid_mobile_app/data/widget/app_bar_widget/app_bar_widget.dart';
import 'package:rapid_mobile_app/data/widget/bottom_bar_widget/home_bottom_bar_widget.dart';
import 'package:rapid_mobile_app/data/widget/container_widget/background_widget.dart';
import 'package:rapid_mobile_app/data/widget/container_widget/home_cardview_widget.dart';
import 'package:rapid_mobile_app/data/widget/drawer_widget/side_drawer.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        elevation: 0,
        child: SideDrawer(),
      ),
      appBar: AppBarWidget(
        title: Strings.kDashboard.tr,
        leadingIcon: Icons.menu,
        actionIcon: Icons.person,
      ),
      body: const BodyWidget(),
      bottomNavigationBar: const HomeBottomBarWidget(),
    );
  }
}

class BodyWidget extends GetView<DashboardController> {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      alignment: Alignment.topLeft,
      childWidget: Obx(
        () => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: controller.firstPageData.length,
          itemBuilder: (context, index) {
            return HomeCardViewWidget(
              // icon: controller.firstPageData[index].mdtIcon,
              icon: Icons.downloading_rounded,
              title: controller.firstPageData[index].mdtTblTitle.toString(),
              iconColor: colours.black,
              backgroundColor: colours.icon_background_light_grey,
            );
          },
        ),
      ),
    );
  }
}
