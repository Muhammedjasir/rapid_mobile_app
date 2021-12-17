import 'package:flutter/material.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
    required this.childWidget,
    required this.alignment,
  }) : super(key: key);

  final Widget childWidget;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                colours.background_top,
                colours.background_bottom,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [-1, 1])),
      alignment: alignment,
      child: childWidget,
    );
  }
}
