import 'package:flutter/material.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class LoginTextFieldWidget extends StatelessWidget {
  // hint,icon,controller
  const LoginTextFieldWidget(
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
          fontWeight: FontWeight.normal,
        ),
        border: const OutlineInputBorder(),
        // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: colours.text_color)),
        prefixIcon: Icon(
          hint == Strings.kPassword ? Icons.remove_red_eye : Icons.person,
          size: 24,
          color: Colors.grey,
        ),
      ),
      controller: _controller,
      keyboardType: hint == Strings.kPassword
          ? TextInputType.visiblePassword
          : TextInputType.name,
      obscureText: hint == Strings.kPassword ? true : false,
    );
  }
}
