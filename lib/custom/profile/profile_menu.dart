// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/font_style.dart';

class ProfileMenu extends StatelessWidget {
  final String image;
  final String text;
  final bool isArrow;
  final double top;
  final double bottom;
  Widget? leading;
  Color? iconColor;
  Color? textColor;
  Function()? onTap;

  ProfileMenu({
    super.key,
    required this.image,
    required this.text,
    required this.isArrow,
    this.leading,
    this.iconColor,
    this.textColor,
    this.onTap,
    required this.top,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            image,
            height: 25,
            color: iconColor,
          ).paddingOnly(right: 13),
          Text(
            text,
            style: AppFontStyle.fontStyleW700(
              fontSize: 15,
              fontColor: textColor ?? AppColors.appButton,
            ),
          ),
          const Spacer(),
          isArrow == true
              ? Image.asset(
                  AppAsset.icArrowLeft,
                  height: 18,
                )
              : leading ?? const SizedBox()
        ],
      ),
    ).paddingOnly(top: top, bottom: bottom);
  }
}
