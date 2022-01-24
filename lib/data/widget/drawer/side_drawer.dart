import 'package:flutter/material.dart';
import 'package:rapid_mobile_app/data/widget/buttons/drawer_elevated_button_widget.dart';
import 'package:rapid_mobile_app/data/widget/text/text_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: colours.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 45),
            child: TextWidget(
              text: "RAPID APP",
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
          const SizedBox(
            width: double.infinity,
            child: DrawerElevatedButtonWidget(
              icon: Icons.settings,
              title: 'Settings',
              colorIconTitle: colours.black,
              colorBackground: colours.yellow,
            ),
          ),
          const SizedBox(
            width: double.infinity,
            child: DrawerElevatedButtonWidget(
                icon: Icons.home,
                title: 'Masters',
                colorIconTitle: colours.yellow,
                colorBackground: colours.icon_background_dark_grey),
          ),
          const SizedBox(
            width: double.infinity,
            child: DrawerElevatedButtonWidget(
                icon: Icons.transform,
                title: 'Transactions',
                colorIconTitle: colours.yellow,
                colorBackground: colours.icon_background_dark_grey),
          ),
          const SizedBox(
            width: double.infinity,
            child: DrawerElevatedButtonWidget(
                icon: Icons.file_copy,
                title: 'BOB Reconciliation',
                colorIconTitle: colours.yellow,
                colorBackground: colours.icon_background_dark_grey),
          ),
        ],
      ),
    );
  }
}