import 'package:flutter/cupertino.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.actionIcon,
    required this.onTapLeadingIcon,
    required this.onTapActionIcon,
  }) : super(key: key);

  final String title;
  final IconData leadingIcon;
  final IconData actionIcon;
  final VoidCallback? onTapLeadingIcon;
  final VoidCallback? onTapActionIcon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: IconWidget(leadingIcon: leadingIcon, onTapLeadingIcon: onTapLeadingIcon),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: TitleWidget(title: title),
            ),
          ),
          Expanded(
            flex: 0,
            child: IconWidget(leadingIcon: actionIcon, onTapLeadingIcon: onTapActionIcon),
          ),
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: colours.black,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    required this.leadingIcon,
    required this.onTapLeadingIcon,
  }) : super(key: key);

  final IconData leadingIcon;
  final VoidCallback? onTapLeadingIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: colours.icon_background_light_grey,
        ),
        child: Icon(
          leadingIcon,
          size: 24,
          color: colours.icon_black,
        ),
      ),
      onTap: onTapLeadingIcon,
    );
  }
}
