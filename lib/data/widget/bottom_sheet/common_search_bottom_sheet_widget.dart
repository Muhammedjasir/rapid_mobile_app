import 'package:flutter/material.dart';
import 'package:rapid_mobile_app/data/widget/container/icon_background_widget.dart';
import 'package:rapid_mobile_app/data/widget/text_fields/text_field_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class CommonSearchBottomSheetWidget extends StatelessWidget {
  const CommonSearchBottomSheetWidget({
    Key? key,
    required TextEditingController controller,
    this.onTap,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: colours.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.only(left: 5, top: 30, bottom: 30),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFieldWidget(
              hint: Strings.kSearchHint,
              controller: _controller,
            ),
            flex: 2,
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            child: IconBackgroundWidget(
              iconColor: colours.white,
              backgroundColor: colours.black,
              icon: Icons.search,
            ),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
