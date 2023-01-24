import 'package:flutter/material.dart';

class TextInputFields extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final String? Function(String?) validator;
  final IconData icon;
  final TextInputType? keyboardType;
  final dynamic ontap;
  const TextInputFields({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.isObscure = false,
    this.keyboardType,
    this.ontap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      onTap: ontap,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide()),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide()),
      ),
      obscureText: isObscure,
    );
  }
}
