import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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