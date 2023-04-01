import 'package:flutter/material.dart';
import '/styles/colors.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool? obsecure;
  final Widget? icon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validating;
  final TextInputType keyboardType;
  final void Function(String)? onSubmit;

  const InputField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.textCapitalization,
    required this.validating,
    required this.keyboardType,
    this.obsecure,
    this.prefixIcon,
    this.icon,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: defaultColor,
        suffixIcon: icon,
        suffixIconColor: defaultColor,
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: defaultColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      cursorColor: Colors.grey[700],
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      obscureText: obsecure!,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      validator: validating,
      onFieldSubmitted: onSubmit,
    );
  }
}
