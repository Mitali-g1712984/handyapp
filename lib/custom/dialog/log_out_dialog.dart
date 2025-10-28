import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 335,
      child: Material(
        shape: const SquircleBorder(
          radius: BorderRadius.all(
            Radius.circular(90),
          ),
        ),
        color: AppColors.white,
        child: Column(
          children: [
            Image.asset(AppAsset.icLogOut, height: 90, color: AppColors.redBox),
            Text(
              EnumLocale.txtLogOut.name.tr,
              style: AppFontStyle.fontStyleW800(
                fontSize: 22,
                fontColor: AppColors.redBox,
              ),
            ).paddingOnly(top: 8),
            Text(
              EnumLocale.desWantLogOutApp.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.fontStyleW500(
                fontSize: 14,
                fontColor: AppColors.categoryText,
              ),
            ).paddingOnly(top: 8, bottom: 13),
            const Spacer(),
            PrimaryAppButton(
              onTap: () {
                Constant.storage.erase();

                Get.offAllNamed(AppRoutes.onBoarding);
              },
              height: 40,
              borderRadius: 8,
              color: AppColors.redBox,
              text: EnumLocale.txtLogOut.name.tr,
              textStyle: AppFontStyle.fontStyleW800(
                fontSize: 17,
                fontColor: AppColors.white,
              ),
            ).paddingOnly(top: 20, bottom: 10),
            PrimaryAppButton(
              onTap: () {
                Get.back();
              },
              height: 40,
              borderRadius: 8,
              color: AppColors.divider,
              text: EnumLocale.txtClose.name.tr,
              textStyle: AppFontStyle.fontStyleW800(
                fontSize: 17,
                fontColor: AppColors.tabUnselectText,
              ),
            ).paddingOnly(bottom: 5)
          ],
        ).paddingAll(15),
      ),
    );
  }
}
