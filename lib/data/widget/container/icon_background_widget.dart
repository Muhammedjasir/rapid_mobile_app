import 'package:flutter/material.dart';

class IconBackgroundWidget extends StatelessWidget {
  const IconBackgroundWidget({
    Key? key,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  }) : super(key: key);

  final IconData icon;
  final Color backgroundColor, iconColor;

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
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        size: 24,
        color: iconColor,
      ),
    );
  }
}
