import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class LoginContainerWidget extends StatelessWidget {
  const LoginContainerWidget({Key? key, required this.childWidget})
      : super(key: key);

  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(35),
        padding: const EdgeInsets.all(25),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: const [
              BoxShadow(
                color: colours.card_background,
                blurRadius: 0.5,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: colours.card_background,
                blurRadius: 0.5,
                spreadRadius: 1,
              ),
            ],
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              width: 0.5,
              color: colours.card_background,
            ),
            shape: BoxShape.rectangle),
        child: childWidget);
  }
}
