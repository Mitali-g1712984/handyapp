import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';

class PaymentConfirmDialog extends StatelessWidget {
  const PaymentConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 545,
      child: Material(
        shape: const SquircleBorder(
          radius: BorderRadius.all(
            Radius.circular(90),
          ),
        ),
        color: AppColors.white,
        child: GetBuilder<ConfirmBookingController>(
          builder: (logic) {
            return Column(
              children: [
                Image.asset(AppAsset.icWallet, height: 117).paddingOnly(top: 8),
                Text(
                  EnumLocale.txtPaymentConfirmation.name.tr,
                  style: AppFontStyle.fontStyleW900(
                    fontSize: 22,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ).paddingOnly(top: 8),
                Text(
                  EnumLocale.desConfirmAppointment.name.tr,
                  textAlign: TextAlign.center,
                  style: AppFontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.categoryText,
                  ),
                ).paddingOnly(top: 8, bottom: 13),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.boxShadow.withOpacity(0.2),
                        blurRadius: 0.3,
                        spreadRadius: 0,
                      ),
                    ],
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.divider.withOpacity(0.5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: "${ApiConstant.BASE_URL}${logic.profileImage}",
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                            },
                            errorWidget: (context, url, error) {
                              return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              logic.name ?? "",
                              style: AppFontStyle.fontStyleW900(
                                fontSize: 16,
                                fontColor: AppColors.appButton,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: logic.color,
                              ),
                              child: Text(
                                logic.services ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: AppFontStyle.fontStyleW600(
                                  fontSize: 12,
                                  fontColor: logic.textColor ?? AppColors.primaryAppColor1,
                                ),
                              ),
                            ),
                            Text(
                              "$currency ${logic.finalAmount}",
                              style: AppFontStyle.fontStyleW800(
                                fontSize: 18,
                                fontColor: AppColors.primaryAppColor1,
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(AppAsset.icStarFilled, height: 14),
                                Text(
                                  "  ${logic.avgRating}",
                                  style: AppFontStyle.fontStyleW800(
                                    fontSize: 15,
                                    fontColor: AppColors.rating,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).paddingAll(5),
                ).paddingOnly(bottom: 15),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '${EnumLocale.desConditionAccept.name.tr}  ',
                    style: AppFontStyle.fontStyleW500(
                      fontSize: 12,
                      fontColor: AppColors.categoryText,
                    ),
                    children: [
                      TextSpan(
                        text: EnumLocale.txtTermsCondition.name.tr,
                        style: AppFontStyle.fontStyleW800(
                          fontSize: 12,
                          fontColor: AppColors.categoryText,
                          textDecoration: TextDecoration.underline,
                          decorationColor: AppColors.categoryText,
                        ),
                      ),
                    ],
                  ),
                ),
                PrimaryAppButton(
                  onTap: () {
                    logic.onPayNowClick();
                  },
                  text: EnumLocale.txtPayNow.name.tr,
                  textStyle: AppFontStyle.fontStyleW800(
                    fontSize: 17,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ).paddingOnly(top: 20, bottom: 15),
                PrimaryAppButton(
                  onTap: () {
                    Get.back();
                  },
                  color: AppColors.divider,
                  text: EnumLocale.txtClose.name.tr,
                  textStyle: AppFontStyle.fontStyleW800(
                    fontSize: 17,
                    fontColor: AppColors.greyText,
                  ),
                ).paddingOnly(bottom: 5)
              ],
            ).paddingAll(15);
          },
        ),
      ),
    );
  }
}
