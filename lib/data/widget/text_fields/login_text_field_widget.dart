import 'package:flutter/material.dart';

class LoginTextFieldWidget extends StatelessWidget {
  // hint,icon,controller
  const LoginTextFieldWidget({
    Key? key,
    required this.hint,
    required TextEditingController controller,
    this.prefixIcon,
    required this.keyboardType,
    required this.obscureText,
    this.obscureClick,
    this.shouldDisplayEyeIcon = false,
  })  : _controller = controller,
        super(key: key);

  final String hint;
  final TextEditingController _controller;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? obscureClick;
  final bool shouldDisplayEyeIcon;

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
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: Visibility(
          visible: shouldDisplayEyeIcon,
          child: IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: obscureClick,
          ),
        ),
      ),
      controller: _controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
