import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class custom_text_field extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;

  final String? Function(String?)? validator;

  const custom_text_field({
    super.key,
    required this.controller,
    required this.hintText,
    this.obsecureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon
      ),
    );
  }
}
