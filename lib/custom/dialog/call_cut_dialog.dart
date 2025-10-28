import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';

class CallCutDialog extends StatelessWidget {
  final String image;
  final String name;
  final String duration;
  const CallCutDialog({super.key, required this.image, required this.name, required this.duration});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 390,
      child: Material(
        shape: const SquircleBorder(radius: BorderRadius.all(Radius.circular(115))),
        color: AppColors.white,
        child: Column(
          children: [
            Container(
              height: 115,
              width: 115,
              decoration: BoxDecoration(
                color: AppColors.primaryAppColor1,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl: "${ApiConstant.BASE_URL}$image",
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                },
                errorWidget: (context, url, error) {
                  return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                },
              ),
            ).paddingOnly(top: 15, bottom: 7),
            Text(
              name,
              style: AppFontStyle.fontStyleW900(
                fontSize: 20,
                fontColor: AppColors.appButton,
              ),
            ).paddingOnly(top: 8),
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            //   decoration: BoxDecoration(
            //     color: AppColors.specialistBox,
            //     borderRadius: BorderRadius.circular(6),
            //   ),
            // child: Text(
            //   'Senior Dentist Surgeon',
            //   style: AppFontStyle.fontStyleW500(
            //     fontSize: 12,
            //     fontColor: AppColors.dialogText,
            //   ),
            // ),
            // ).paddingOnly(top: 15, bottom: 13),
            Text(
              EnumLocale.txtCallDuration.name.tr,
              style: AppFontStyle.fontStyleW600(
                fontSize: 15,
                fontColor: AppColors.categoryText,
              ),
            ),
            Text(
              duration,
              style: AppFontStyle.fontStyleW800(
                fontSize: 18,
                fontColor: AppColors.appButton,
              ),
            ).paddingOnly(top: 8, bottom: 8),
            Text(
              EnumLocale.txtMinutes.name.tr,
              style: AppFontStyle.fontStyleW500(
                fontSize: 12,
                fontColor: AppColors.categoryText,
              ),
            ),
            const Spacer(),
            PrimaryAppButton(
              onTap: () {
                Get.back();
              },
              height: 52,
              color: AppColors.redBox,
              text: "Close",
              textStyle: AppFontStyle.fontStyleW800(
                fontSize: 17,
                fontColor: AppColors.white,
              ),
            ).paddingOnly(top: 20, bottom: 30),
          ],
        ).paddingAll(15),
      ),
    );
  }
}
