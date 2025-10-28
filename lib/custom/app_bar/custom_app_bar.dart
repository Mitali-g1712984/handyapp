// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/font_style.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  List<Widget>? action;
  List<Color>? gradientColor;
  Color? textColor;
  Color? iconColor;
  final bool showLeadingIcon;
  Function()? onTap;

  CustomAppBar({
    super.key,
    required this.title,
    this.action,
    required this.showLeadingIcon,
    this.gradientColor,
    this.textColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(55),
      child: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColor ??
                  [
                    AppColors.primaryAppColor1,
                    AppColors.primaryAppColor1,
                  ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        leading: showLeadingIcon == true
            ? InkWell(
                onTap: onTap ??
                    () {
                      Get.back();
                    },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    AppAsset.icArrowRight,
                    color: iconColor ?? AppColors.white,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        actions: action,
        title: Text(
          title,
          style: AppFontStyle.fontStyleW800(
            fontSize: 20,
            fontColor: textColor ?? AppColors.white,
          ),
        ),
      ),
    );
  }
}
