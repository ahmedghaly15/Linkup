import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global/app_colors.dart';
import '../global/app_styles.dart';

class InputField extends StatelessWidget {
  final FocusNode? focusNode;
  final String hint;
  final TextStyle? hintStyle;
  final bool? obsecure;
  final Widget? icon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validating;
  final TextInputType keyboardType;
  final void Function(String)? onSubmit;
  final void Function()? onEditingComplete;

  const InputField({
    Key? key,
    required this.hint,
    this.hintStyle = AppStyles.hintStyle,
    required this.controller,
    required this.textCapitalization,
    required this.validating,
    required this.keyboardType,
    this.obsecure,
    this.prefixIcon,
    this.icon,
    this.onSubmit,
    this.onEditingComplete,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? AppColors.darkHeaderClr
            : AppColors.inputFieldColor,
        borderRadius: BorderRadius.circular(0),
      ),
      child: TextFormField(
        key: key,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintStyle,
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.primaryColor,
          suffixIcon: icon,
          suffixIconColor: AppColors.primaryColor,
          contentPadding: const EdgeInsets.all(16),
          enabledBorder: buildOutlineInputBorder(
            Get.isDarkMode ? AppColors.darkGreyClr : Colors.white,
            0,
          ),
          focusedBorder: buildOutlineInputBorder(AppColors.primaryColor, 2),
          errorBorder: buildOutlineInputBorder(Colors.redAccent, 2),
        ),
        cursorColor: AppColors.primaryColor,
        style: AppStyles.inputFieldTextStyle,
        obscureText: obsecure!,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        validator: validating,
        onFieldSubmitted: onSubmit,
        onEditingComplete: onEditingComplete,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
      borderRadius: BorderRadius.circular(0),
    );
  }
}
