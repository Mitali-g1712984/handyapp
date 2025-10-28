import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/font_style.dart';

class AppointmentRequiredDialog extends StatelessWidget {
  const AppointmentRequiredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Material(
        shape: const SquircleBorder(
          radius: BorderRadius.all(
            Radius.circular(95),
          ),
        ),
        color: AppColors.white,
        child: Column(
          children: [
            Image.asset(AppAsset.icAppointmentFilled, height: 100),
            Text(
              EnumLocale.txtAppointmentRequired.name.tr,
              style: AppFontStyle.fontStyleW700(
                fontSize: 22,
                fontColor: AppColors.appButton,
              ),
            ).paddingOnly(top: 8),
            Text(
              EnumLocale.desAppointmentRequired.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.fontStyleW400(
                fontSize: 15,
                fontColor: AppColors.appText,
              ),
            ).paddingOnly(top: 8, bottom: 13, left: 15, right: 15),
            const Spacer(),
            PrimaryAppButton(
              onTap: () {
                Get.back();
              },
              text: EnumLocale.txtClose.name.tr,
              textStyle: AppFontStyle.fontStyleW600(
                fontSize: 15.5,
                fontColor: AppColors.white,
              ),
            ).paddingOnly(bottom: 10,left: 5,right: 5)
          ],
        ).paddingAll(15),
      ),
    );
  }
}
