import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
          activeIcon: const SelectedIconWidget(
            icon: Icons.dashboard_rounded,
          ),
          icon: const UnSelectedIconWidget(
            icon: Icons.dashboard_rounded,
          ),
        ),
        BottomNavigationBarItem(
          label: Strings.kHome.tr,
          activeIcon: const SelectedIconWidget(
            icon: Icons.home,
          ),
          icon: const UnSelectedIconWidget(
            icon: Icons.home,
          ),
        ),
        BottomNavigationBarItem(
          label: Strings.kCalander.tr,
          activeIcon: const SelectedIconWidget(
            icon: Icons.calendar_today,
          ),
          icon: const UnSelectedIconWidget(
            icon: Icons.calendar_today,
          ),
        ),
      ],
    );
  }
}

class SelectedIconWidget extends StatelessWidget {
  const SelectedIconWidget({Key? key, required this.icon}) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        color: colours.yellow,
      ),
      child: Icon(
        icon,
        size: 24,
        color: colours.black,
      ),
    );
  }
}

class UnSelectedIconWidget extends StatelessWidget {
  const UnSelectedIconWidget({Key? key, required this.icon}) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        color: colours.icon_background_dark_grey,
      ),
      child: Icon(
        icon,
        size: 24,
        color: colours.yellow,
      ),
    );
  }
}
