import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';

class AppMaintenanceDialog extends StatelessWidget {
  const AppMaintenanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.52,
      child: Material(
        shape: const SquircleBorder(
          radius: BorderRadius.all(
            Radius.circular(95),
          ),
        ),
        color: AppColors.white,
        child: Column(
          children: [
            Image.asset(
              AppAsset.icUploadImage,
              height: 200,
            ),
            Text(
              EnumLocale.txtUnderMaintenance.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.fontStyleW700(
                fontSize: 22,
                fontColor: AppColors.title,
              ),
            ).paddingOnly(top: 8),
            Text(
              EnumLocale.desEnterUnderAppMaintenance.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.fontStyleW400(
                fontSize: 15,
                fontColor: AppColors.degreeText,
              ),
            ).paddingOnly(top: 8, bottom: 13, left: 15, right: 15),
            const Spacer(),
            PrimaryAppButton(
              onTap: () {
                Get.back();
              },
              color: AppColors.redBox,
              borderRadius: 54,
              text: EnumLocale.txtCloseApp.name.tr,
              textStyle: AppFontStyle.fontStyleW600(
                fontSize: 15.5,
                fontColor: AppColors.white,
              ),
            ).paddingOnly(top: 20, bottom: 15, left: 15, right: 15),
          ],
        ).paddingAll(15),
      ),
    );
  }
}
