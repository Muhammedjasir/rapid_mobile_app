import 'package:flutter/material.dart';

class RapidLoadingIndicator extends StatelessWidget {
  const RapidLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.grey,
        border: BorderDirectional(
          top: BorderSide(
            width: 1.0,
            color: Color(0x42000000),
          ),
        ),
      ),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
          Colors.black54,
        ),
      ),
    );
  }
}
