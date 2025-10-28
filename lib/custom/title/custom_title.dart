import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/font_style.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final Widget method;

  const CustomTitle({
    super.key,
    required this.title,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFontStyle.fontStyleW700(
            fontSize: 16,
            fontColor: AppColors.categoryText,
          ),
        ).paddingOnly(bottom: 12, left: 5),
        method,
      ],
    );
  }
}
