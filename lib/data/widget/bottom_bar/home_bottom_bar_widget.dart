import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:rapid_mobile_app/data/widget/container/icon_background_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class HomeBottomBarWidget extends StatefulWidget {
  const HomeBottomBarWidget({
    Key? key,
    required this.onItemTap,
  }) : super(key: key);

  final Function onItemTap;

  @override
  State<HomeBottomBarWidget> createState() => _HomeBottomBarWidgetState();
}

class _HomeBottomBarWidgetState extends State<HomeBottomBarWidget> {
  int bottomBarSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: colours.black,
      selectedItemColor: colours.white,
      unselectedItemColor: colours.yellow,
      type: BottomNavigationBarType.fixed,
      currentIndex: bottomBarSelectedIndex,
      onTap: (int index) {
        setState(() {
          bottomBarSelectedIndex = index;
        });
        widget.onItemTap(index);
      },
      items: [
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
          label: Strings.kCalendar.tr,
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
