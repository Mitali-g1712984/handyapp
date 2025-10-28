import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/font_style.dart';

class ProfileCustomTitle extends StatelessWidget {
  final String title;
  final Widget widget;
  const ProfileCustomTitle({super.key, required this.title, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFontStyle.fontStyleW700(
            fontSize: 17,
            fontColor: AppColors.categoryText,
          ),
        ).paddingOnly(left: 5, bottom: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.boxShadow.withOpacity(0.2),
                blurRadius: 1,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: widget,
        )
      ],
    ).paddingOnly(left: 13, right: 13);
  }
}
