import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';

class ViewAllTitle extends StatelessWidget {
  const ViewAllTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.txtViewAll.name.tr,
      style: AppFontStyle.fontStyleW600(
        fontSize: 12,
        fontColor: AppColors.appButton,
      ),
    );
  }
}
