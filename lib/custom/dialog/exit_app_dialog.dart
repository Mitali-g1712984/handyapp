import 'dart:io';

import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/font_style.dart';

class ExitAppDialog extends StatelessWidget {
  const ExitAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 365,
      child: Material(
        shape: const SquircleBorder(
          radius: BorderRadius.all(
            Radius.circular(115),
          ),
        ),
        color: AppColors.white,
        child: Column(
          children: [
            Image.asset(AppAsset.icLogOut),
            Text(
              EnumLocale.txtExitApp.name.tr,
              style: AppFontStyle.fontStyleW800(
                fontSize: 22,
                fontColor: AppColors.appButton,
              ),
            ).paddingOnly(top: 8),
            Text(
              EnumLocale.desWantExitApp.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.fontStyleW500(
                fontSize: 17,
                fontColor: AppColors.appText,
              ),
            ).paddingOnly(top: 8, bottom: 13),
            const Spacer(),
            PrimaryAppButton(
              onTap: () {
                exit(0);
              },
              height: 48,
              borderRadius: 8,
              text: EnumLocale.txtExitApp.name.tr,
              textStyle: AppFontStyle.fontStyleW800(
                fontSize: 17,
                fontColor: AppColors.white,
              ),
            ).paddingOnly(top: 20, bottom: 10, left: 5, right: 5),
            PrimaryAppButton(
              onTap: () {
                Get.back();
              },
              height: 48,
              borderRadius: 8,
              color: AppColors.divider,
              text: EnumLocale.txtClose.name.tr,
              textStyle: AppFontStyle.fontStyleW800(
                fontSize: 17,
                fontColor: AppColors.tabUnselectText,
              ),
            ).paddingOnly(bottom: 10, left: 5, right: 5)
          ],
        ).paddingAll(15),
      ),
    );
  }
}
