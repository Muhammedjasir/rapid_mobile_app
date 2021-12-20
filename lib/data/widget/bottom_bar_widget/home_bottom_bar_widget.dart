import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:rapid_mobile_app/data/widget/container_widget/icon_background_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class HomeBottomBarWidget extends StatelessWidget {
  const HomeBottomBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: colours.black,
      selectedItemColor: colours.white,
      unselectedItemColor: colours.yellow,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          label: Strings.kDashboard.tr,
          activeIcon: const IconBackgroundWidget(
            icon: Icons.dashboard_rounded,
            backgroundColor: colours.yellow,
            iconColor: colours.black,
          ),
          icon: const IconBackgroundWidget(
            icon: Icons.dashboard_rounded,
            backgroundColor: colours.icon_background_dark_grey,
            iconColor: colours.yellow,
          ),
        ),
        BottomNavigationBarItem(
          label: Strings.kHome.tr,
          activeIcon: const IconBackgroundWidget(
            icon: Icons.home,
            backgroundColor: colours.yellow,
            iconColor: colours.black,
          ),
          icon: const IconBackgroundWidget(
            icon: Icons.home,
            backgroundColor: colours.icon_background_dark_grey,
            iconColor: colours.yellow,
          ),
        ),
        BottomNavigationBarItem(
          label: Strings.kCalander.tr,
          activeIcon: const IconBackgroundWidget(
            icon: Icons.calendar_today,
            backgroundColor: colours.yellow,
            iconColor: colours.black,
          ),
          icon: const IconBackgroundWidget(
            icon: Icons.calendar_today,
            backgroundColor: colours.icon_background_dark_grey,
            iconColor: colours.yellow,
          ),
        ),
      ],
    );
  }
}
