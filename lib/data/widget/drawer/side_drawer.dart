import 'package:flutter/material.dart';
import 'package:rapid_mobile_app/data/module/home/home_page.dart';
import 'package:rapid_mobile_app/data/widget/buttons/drawer_elevated_button_widget.dart';
import 'package:rapid_mobile_app/data/widget/text/text_widget.dart';
import 'package:rapid_mobile_app/res/utils/rapid_pref.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: colours.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: TextWidget(
              text: RapidPref().getProjectName().toString(),
              textSize: 22,
              textColor: colours.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: TextWidget(
              text: "Version 1.0",
              textSize: 15,
              textColor: colours.white,
            ),
          ),
          Container(
            height: 1,
            color: colours.white,
            margin: const EdgeInsets.only(
              top: 30,
              bottom: 10,
            ),
          ),
           SizedBox(
            width: double.infinity,
            child: DrawerElevatedButtonWidget(
              icon: Icons.lock,
              title: Strings.kChangePassword,
              colorIconTitle: colours.yellow,
              colorBackground: colours.icon_background_dark_grey,
              onTap: _onPress,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: DrawerElevatedButtonWidget(
              icon: Icons.settings,
              title: Strings.kSettings,
              colorIconTitle: colours.yellow,
              colorBackground: colours.icon_background_dark_grey,
              onTap: _onPress,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: DrawerElevatedButtonWidget(
              icon: Icons.logout,
              title: Strings.kLogout,
              colorIconTitle: colours.yellow,
              colorBackground: colours.icon_background_dark_grey,
              onTap: _onLogoutPress,
            ),
          ),
        ],
      ),
    );
  }

  void _onLogoutPress() {
    onLogout();
  }

  void _onPress() {}

}
