import 'package:flutter/cupertino.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class HomeCardViewWidget extends StatelessWidget {
  const HomeCardViewWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.iconColor,
      required this.backgroundColor})
      : super(key: key);

  final String? icon;
  final Color backgroundColor, iconColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor,
      ),
      child: Row(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(5),
            // child: Icon(
            //   FontAwesomeIcons[icon],
            //   size: 24,
            //   color: iconColor,
            // ),
          ),
          Padding(padding: const EdgeInsets.all(5),
          child: Text(
            title,
            style: const TextStyle(
                color: colours.black,
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold),
          ),)
        ],
      ),
    );
  }
}
