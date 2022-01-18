import 'package:flutter/cupertino.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class HomeCardViewWidget extends StatelessWidget {
  const HomeCardViewWidget(
      {Key? key,
        required this.icon,
        required this.title,
        required this.iconColor,
        required this.backgroundColor,
        this.onTap})
      : super(key: key);

  final IconData icon;
  final Color backgroundColor, iconColor;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Icon(
                  icon,
                  size: 48,
                  color: iconColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 5,
                left: 5,
                bottom: 30,
              ),
              child: Text(
                title,
                style: const TextStyle(
                    color: colours.black,
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
