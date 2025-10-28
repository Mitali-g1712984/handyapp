import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/confirm_appointment_screen/controller/confirm_appointment_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/global_variables.dart';

/// =================== Payment Top view =================== ///
class ConfirmAppointmentPaymentView extends StatelessWidget {
  const ConfirmAppointmentPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: AppColors.primaryAppColor1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAsset.icConfirm,
            height: 200,
            width: 200,
          ).paddingOnly(top: Get.height * 0.075, bottom: 15),
          Text(
            EnumLocale.txtAppointmentConfirm.name.tr,
            style: AppFontStyle.fontStyleW900(
              fontSize: 24,
              fontColor: AppColors.white,
            ),
          ).paddingOnly(top: 10),
          Text(
            EnumLocale.txtPaymentSuccessful.name.tr,
            style: AppFontStyle.fontStyleW500(
              fontSize: 18,
              fontColor: AppColors.white,
            ),
          ).paddingOnly(bottom: 25)
        ],
      ),
    );
  }
}

/// =================== Appointment Information =================== ///
class ConfirmAppointmentInfoView extends StatelessWidget {
  const ConfirmAppointmentInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadow.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 0,
          ),
        ],
      ),
      child: GetBuilder<ConfirmAppointmentController>(
        builder: (logic) {
          return Row(
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
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 12,
                          fontColor: logic.textColor ?? AppColors.primaryAppColor1,
                        ),
                      ),
                    ),
                    Text(
                      "$currency ${logic.price}",
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
          ).paddingAll(12);
        },
      ),
    );
  }
}

class ConfirmAppointmentServiceView extends StatelessWidget {
  const ConfirmAppointmentServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryAppColor1,
          width: 0.7,
        ),
      ),
      child: GetBuilder<ConfirmAppointmentController>(
        builder: (logic) {
          return Column(
            children: [
              Container(
                height: 42,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryAppColor1,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    EnumLocale.txtServiceBookingSchedule.name.tr,
                    style: AppFontStyle.fontStyleW800(
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(left: 15),
                ),
              ),
              Divider(height: 3, color: AppColors.white),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryAppColor1,
                    ),
                    child: Image.asset(
                      AppAsset.icAppointmentFilled,
                      color: AppColors.white,
                    ).paddingAll(10),
                  ).paddingOnly(right: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        logic.formattedDate ?? "",
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 14,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                      Text(
                        EnumLocale.txtBookingDate.name.tr,
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 12,
                          fontColor: AppColors.categoryText,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 36,
                    width: 2,
                    color: AppColors.serviceBorder,
                  ),
                  const Spacer(),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryAppColor1,
                    ),
                    child: Image.asset(AppAsset.icClock).paddingAll(10),
                  ).paddingOnly(right: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        logic.selectedSlotsList ?? "",
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 14,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                      Text(
                        EnumLocale.txtBookingTiming.name.tr,
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 12,
                          fontColor: AppColors.categoryText,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                ],
              ).paddingOnly(top: 12.5, bottom: 12.5, right: 15, left: 15)
            ],
          );
        },
      ),
    ).paddingOnly(left: 15, right: 15, top: 20);
  }
}

/// =================== Bottom View =================== ///
class ConfirmAppointmentBottomView extends StatelessWidget {
  const ConfirmAppointmentBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryAppButton(
      onTap: () {
        Get.offAllNamed(AppRoutes.bottom);
      },
      text: EnumLocale.txtBackHomePage.name.tr,
      textStyle: AppFontStyle.fontStyleW800(
        fontSize: 17,
        fontColor: AppColors.primaryAppColor1,
      ),
    ).paddingAll(15);
  }
}
