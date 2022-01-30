import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key, required this.hint, required TextEditingController controller})
      : _controller = controller,
        super(key: key);

  final String hint;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        border: const OutlineInputBorder(),
        // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: colours.text_color)),
      ),
      controller: _controller,
      keyboardType: TextInputType.name,
      obscureText: false,
    );
  }
}
