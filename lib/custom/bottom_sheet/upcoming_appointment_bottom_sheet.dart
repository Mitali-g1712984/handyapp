import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/dialog/cancel_appointment_dialog.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/appointment_screen/controller/appointment_screen_controller.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';

class UpcomingAppointmentBottomSheet extends StatelessWidget {
  final String profileImage;
  final String providerName;
  final String serviceName;
  final String serviceProviderFee;
  final String rating;
  final String appointmentUniqueId;
  final String time;
  final String date;
  final String appointmentId;
  final String providerId;
  final bool isViewAll;

  const UpcomingAppointmentBottomSheet({
    super.key,
    required this.profileImage,
    required this.providerName,
    required this.serviceName,
    required this.serviceProviderFee,
    required this.rating,
    required this.appointmentUniqueId,
    required this.time,
    required this.date,
    required this.appointmentId,
    required this.isViewAll,
    required this.providerId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 345,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
              color: AppColors.primaryAppColor1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  EnumLocale.txtUpcomingAppointment.name.tr,
                  style: AppFontStyle.fontStyleW800(
                    fontSize: 19,
                    fontColor: AppColors.white,
                  ),
                ).paddingOnly(left: 20),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppAsset.icClose,
                    height: Get.height * 0.07,
                    width: Get.width * 0.07,
                  ).paddingOnly(right: 15),
                )
              ],
            ),
          ),
          Divider(height: 1.2, color: AppColors.bottomSheetDivider),
          InkWell(
            onTap: () {
              Get.toNamed(
                AppRoutes.bookingInformation,
                arguments: [
                  appointmentId,
                  AppColors.colorList[0],
                  AppColors.textColorList[0],
                ],
              );
            },
            child: Container(
              height: 235,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  width: 1.5,
                  color: AppColors.serviceBorder,
                ),
              ),
              child: Column(
                children: [
                  Row(
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
                            imageUrl: "${ApiConstant.BASE_URL}$profileImage",
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
                              providerName,
                              style: AppFontStyle.fontStyleW900(
                                fontSize: 16,
                                fontColor: AppColors.appButton,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.colorList[0],
                              ),
                              child: Text(
                                serviceName,
                                style: AppFontStyle.fontStyleW600(
                                  fontSize: 12,
                                  fontColor: AppColors.textColorList[0],
                                ),
                              ),
                            ),
                            Text(
                              "$currency $serviceProviderFee",
                              style: AppFontStyle.fontStyleW800(
                                fontSize: 18,
                                fontColor: AppColors.primaryAppColor1,
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(AppAsset.icStarFilled, height: 14),
                                Text(
                                  "  $rating",
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
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.divider,
                        ),
                        child: Text(
                          appointmentUniqueId,
                          style: AppFontStyle.fontStyleW600(
                            fontSize: 12,
                            fontColor: AppColors.tabUnselectText,
                          ),
                        ),
                      ).paddingOnly(bottom: 3),
                    ],
                  ).paddingOnly(left: 7, right: 7),
                  Container(
                    color: AppColors.divider,
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                    child: Row(
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
                              time,
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
                              date,
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
                      ],
                    ),
                  ).paddingOnly(top: 12),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryAppButton(
                          onTap: () {
                            Get.dialog(
                              barrierColor: AppColors.black.withOpacity(0.8),
                              GetBuilder<AppointmentScreenController>(
                                id: Constant.idCancelAppointment,
                                builder: (logic) {
                                  return ProgressDialog(
                                    inAsyncCall: logic.isLoading2,
                                    child: Dialog(
                                      backgroundColor: AppColors.transparent,
                                      shadowColor: Colors.transparent,
                                      surfaceTintColor: Colors.transparent,
                                      elevation: 0,
                                      child: CancelAppointmentDialog(
                                        appointmentId: appointmentId,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          height: 40,
                          borderRadius: 8,
                          color: AppColors.redBox,
                          text: EnumLocale.txtCancelAppointment.name.tr,
                          textStyle: AppFontStyle.fontStyleW800(
                            fontSize: 15,
                            fontColor: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GetBuilder<HomeScreenController>(
                        id: Constant.idGetUpcomingAppointment,
                        builder: (logic) {
                          return Expanded(
                            child: PrimaryAppButton(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.schedule,
                                  arguments: [
                                    profileImage,
                                    providerName,
                                    serviceName,
                                    serviceProviderFee,
                                    rating,
                                    date,
                                    time,
                                    providerId,
                                    AppColors.colorList[0],
                                    AppColors.textColorList[0],
                                    appointmentId,
                                  ],
                                )?.then(
                                  (value) async {
                                    await logic.getUpcomingAppointmentApiCall();
                                  },
                                );
                              },
                              height: 40,
                              borderRadius: 8,
                              color: AppColors.primaryAppColor1,
                              text: EnumLocale.txtReSchedule.name.tr,
                              textStyle: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ).paddingOnly(left: 7, right: 7, top: 10)
                ],
              ).paddingOnly(top: 7, bottom: 7),
            ).paddingOnly(left: 12, right: 12, bottom: 10, top: 10),
          )
        ],
      ),
    );
  }
}
