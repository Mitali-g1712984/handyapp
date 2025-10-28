import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/font_style.dart';

class CustomMainTitle extends StatelessWidget {
  final String title;
  final Widget method;
  const CustomMainTitle({super.key, required this.title, required this.method});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppFontStyle.fontStyleW800(
            fontSize: 18,
            fontColor: AppColors.mainTitleText,
          ),
        ).paddingOnly(left: 5),
        method,
      ],
    );
  }
}
