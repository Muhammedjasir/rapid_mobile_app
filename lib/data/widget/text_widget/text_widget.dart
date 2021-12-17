import 'package:flutter/cupertino.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class TextWidget extends StatelessWidget{
  const TextWidget({Key? key,required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: const TextStyle(
          color: colours.text_color,
          fontSize: 22,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold),
    );
  }
  
}