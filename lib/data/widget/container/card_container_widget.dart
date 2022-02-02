import 'package:flutter/material.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class CardContainerWidget extends StatelessWidget{
  const CardContainerWidget ({Key? key,required this.cardWidget,})
      : super(key: key);

  final Widget cardWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: colours.card_background,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              width: 0.5,
              color: colours.card_background,
            ),
            shape: BoxShape.rectangle),
        child: cardWidget);

  }

}
