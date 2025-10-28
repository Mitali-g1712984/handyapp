// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/font_style.dart';

class CustomInfoBox extends StatelessWidget {
  final String title;
  String? text;
  final bool isIndex;
  Widget? widget;

  CustomInfoBox({
    super.key,
    required this.title,
    required this.isIndex,
    this.widget,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppFontStyle.fontStyleW400(
            fontSize: 11.5,
            fontColor: AppColors.degreeText,
          ),
        ),
        isIndex == true
            ? widget ?? const SizedBox()
            : Text(
                text ?? "",
                style: AppFontStyle.fontStyleW600(
                  fontSize: 11.5,
                  fontColor: AppColors.title,
                ),
              )
      ],
    ).paddingOnly(bottom: 15);
  }
}
