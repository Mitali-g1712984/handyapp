import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 351,
      child: Material(
        shape: const SquircleBorder(
          radius: BorderRadius.all(
            Radius.circular(90),
          ),
        ),
        color: AppColors.white,
        child: Column(
          children: [
            Image.asset(AppAsset.icDeleteAccount, height: 90),
            Text(
              EnumLocale.txtDeleteAccount.name.tr,
              style: AppFontStyle.fontStyleW800(
                fontSize: 22,
                fontColor: AppColors.redBox,
              ),
            ).paddingOnly(top: 8),
            Text(
              EnumLocale.desWantDeleteAccount.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.fontStyleW500(
                fontSize: 14,
                fontColor: AppColors.categoryText,
              ),
            ).paddingOnly(top: 8, bottom: 13),
            const Spacer(),
            GetBuilder<ProfileScreenController>(
              builder: (logic) {
                return PrimaryAppButton(
                  onTap: () {
                    logic.onDeleteAccountClick();
                  },
                  height: 48,
                  borderRadius: 8,
                  color: AppColors.redBox,
                  text: EnumLocale.txtDeleteAccount.name.tr,
                  textStyle: AppFontStyle.fontStyleW800(
                    fontSize: 17,
                    fontColor: AppColors.white,
                  ),
                ).paddingOnly(top: 20, bottom: 10);
              },
            ),
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
            ).paddingOnly(bottom: 5)
          ],
        ).paddingAll(15),
      ),
    );
  }
}
