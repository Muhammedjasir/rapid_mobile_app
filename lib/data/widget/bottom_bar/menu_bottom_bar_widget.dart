import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:rapid_mobile_app/data/widget/container/icon_background_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class MenuBottomBarWidget extends StatefulWidget {
  const MenuBottomBarWidget({Key? key, required this.onItemTap})
      : super(key: key);

  final Function onItemTap;

  @override
  State<MenuBottomBarWidget> createState() => _MenuBottomBarWidgetState();
}

class _MenuBottomBarWidgetState extends State<MenuBottomBarWidget> {
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
          label: Strings.kAdd.tr,
          activeIcon: const IconBackgroundWidget(
            icon: Icons.add,
            backgroundColor: colours.yellow,
            iconColor: colours.black,
          ),
          icon: const IconBackgroundWidget(
            icon: Icons.add,
            backgroundColor: colours.icon_background_dark_grey,
            iconColor: colours.yellow,
          ),
        ),
        BottomNavigationBarItem(
          label: Strings.kSearch.tr,
          activeIcon: const IconBackgroundWidget(
            icon: Icons.search,
            backgroundColor: colours.yellow,
            iconColor: colours.black,
          ),
          icon: const IconBackgroundWidget(
            icon: Icons.search,
            backgroundColor: colours.icon_background_dark_grey,
            iconColor: colours.yellow,
          ),
        ),
        BottomNavigationBarItem(
          label: Strings.kAdvanceSearch.tr,
          activeIcon: const IconBackgroundWidget(
            icon: Icons.zoom_in,
            backgroundColor: colours.yellow,
            iconColor: colours.black,
          ),
          icon: const IconBackgroundWidget(
            icon: Icons.zoom_in,
            backgroundColor: colours.icon_background_dark_grey,
            iconColor: colours.yellow,
          ),
        ),
        BottomNavigationBarItem(
          label: Strings.kFilter.tr,
          activeIcon: const IconBackgroundWidget(
            icon: Icons.filter_alt_outlined,
            backgroundColor: colours.yellow,
            iconColor: colours.black,
          ),
          icon: const IconBackgroundWidget(
            icon: Icons.filter_alt_outlined,
            backgroundColor: colours.icon_background_dark_grey,
            iconColor: colours.yellow,
          ),
        ),
        BottomNavigationBarItem(
          label: Strings.kExportExcel.tr,
          activeIcon: const IconBackgroundWidget(
            icon: FontAwesomeIcons.fileExcel,
            backgroundColor: colours.yellow,
            iconColor: colours.black,
          ),
          icon: const IconBackgroundWidget(
            icon: FontAwesomeIcons.fileExcel,
            backgroundColor: colours.icon_background_dark_grey,
            iconColor: colours.yellow,
          ),
        ),
        BottomNavigationBarItem(
          label: Strings.kExportPdf.tr,
          activeIcon: const IconBackgroundWidget(
            icon: FontAwesomeIcons.filePdf,
            backgroundColor: colours.yellow,
            iconColor: colours.black,
          ),
          icon: const IconBackgroundWidget(
            icon: FontAwesomeIcons.filePdf,
            backgroundColor: colours.icon_background_dark_grey,
            iconColor: colours.yellow,
          ),
        ),
      ],
    );
  }
}
