import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rapid_mobile_app/data/widget/container_widget/icon_background_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.actionIcon,
    // required this.onTapLeadingIcon,
    // required this.onTapActionIcon,
  }) : super(key: key);

  final String title;
  final IconData leadingIcon;
  final IconData actionIcon;
  // final VoidCallback? onTapLeadingIcon;
  // final VoidCallback? onTapActionIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          top: 15,
        ),
        child: IconBackgroundWidget(
          icon: leadingIcon,
          backgroundColor: colours.icon_background_light_grey,
          iconColor: colours.black,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            left: 5,
            top: 15,
          ),
          child: IconBackgroundWidget(
            icon: actionIcon,
            backgroundColor: colours.icon_background_light_grey,
            iconColor: colours.black,
          ),
        ),
      ],
      elevation: 0,
      backgroundColor: colours.background_top,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
