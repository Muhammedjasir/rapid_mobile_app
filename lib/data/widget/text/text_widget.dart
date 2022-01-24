import 'package:flutter/cupertino.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.text,
    required this.textSize,
    this.alignment,
    required this.textColor,
  }) : super(key: key);

  final String text;
  final double textSize;
  final TextAlign? alignment;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment,
      style: TextStyle(
          color: textColor,
          fontSize: textSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold),
    );
  }
}
