import 'package:flutter/material.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    Key? key,
    this.onTap,
    required this.label,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(
          MediaQuery.of(context).size.width,
          45,
        ),
        primary: colours.white,
        backgroundColor: colours.black,
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Text(label.toUpperCase()),
      onPressed: onTap,
    );
  }
}
