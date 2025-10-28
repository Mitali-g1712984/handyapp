// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/font_style.dart';

class CustomTextField extends StatelessWidget {
  final bool filled;
  bool? obscureText;
  String? hintText;
  Color? fillColor;
  Color? hintTextColor;
  Color? cursorColor;
  Color? fontColor;
  double? hintTextSize;
  double? fontSize;
  int? maxLines;
  bool? readOnly;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextEditingController? controller;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  String? Function(String?)? onChanged;

  CustomTextField({
    super.key,
    required this.filled,
    this.obscureText,
    this.hintText,
    this.fillColor,
    this.fontColor,
    this.cursorColor,
    this.maxLines,
    this.readOnly,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.hintTextColor,
    this.hintTextSize,
    this.fontSize,
    this.textInputAction,
    this.textInputType,
    this.validator,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      cursorColor: cursorColor,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      style: AppFontStyle.fontStyleW600(
        fontSize: fontSize ?? 13,
        fontColor: fontColor ?? AppColors.primaryAppColor1,
      ),
      textInputAction: textInputAction,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.mainTitleText),
        ),
        fillColor: fillColor,
        filled: filled,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: AppFontStyle.fontStyleW500(
          fontSize: hintTextSize ?? 0.0,
          fontColor: hintTextColor ?? AppColors.transparent,
        ),
      ),
    );
  }
}
