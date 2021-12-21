import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/dashboard/dashboard_controller.dart';
import 'package:rapid_mobile_app/data/widget/app_bar_widget/app_bar_widget.dart';
import 'package:rapid_mobile_app/data/widget/bottom_bar_widget/home_bottom_bar_widget.dart';
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
      body: _bodyWidget(context),
      bottomNavigationBar: const HomeBottomBarWidget(),
    );
  }
}

class DrawerElevatedButtonWidget extends StatelessWidget {
  const DrawerElevatedButtonWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.colorIconTitle,
    required this.colorBackground,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Color colorIconTitle, colorBackground;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        icon,
        color: colorIconTitle,
        size: 24.0,
      ),
      label: Text(
        title,
        style: TextStyle(
            color: colorIconTitle,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600),
      ),
      onPressed: () {
        log("Pressed");
      },
      style: ElevatedButton.styleFrom(
        primary: colorBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}

Widget _bodyWidget(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          colors: [
            colours.background_top,
            colours.background_bottom,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [-707, -169]),
    ),
    child: Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          // child: const AppBottomBarWidget(),
        ),
      ],
    ),
  );
}
