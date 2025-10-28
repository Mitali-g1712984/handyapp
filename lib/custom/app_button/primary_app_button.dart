// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_color.dart';

class PrimaryAppButton extends StatelessWidget {
  double? height;
  double? width;
  double? borderRadius;
  TextStyle? textStyle;
  List<Color>? gradientColor;
  double? iconPadding;
  Color? color;
  Color? borderColor;
  String? text;
  Widget? widget;
  TextOverflow? overflow;
  Function()? onTap;

  PrimaryAppButton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.textStyle,
    this.gradientColor,
    this.iconPadding,
    this.color,
    this.borderColor,
    this.text,
    this.widget,
    this.onTap,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 48,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          gradient: LinearGradient(
            colors: gradientColor ?? [color ?? AppColors.appButton, color ?? AppColors.appButton],
          ),
          border: Border.all(
            color: borderColor ?? AppColors.transparent,
            width: 0.8,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget ?? const SizedBox.shrink(),
            Center(
              child: Text(
                text ?? "",
                overflow: overflow,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
