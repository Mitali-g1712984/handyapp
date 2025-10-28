import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/bottom_sheet/upcoming_appointment_bottom_sheet.dart';
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

/// =================== App Bar =================== ///
class UpcomingAppointmentAppBarView extends StatelessWidget {
  const UpcomingAppointmentAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtUpcomingAppointment.name.tr,
      showLeadingIcon: true,
    );
  }
}

class UpcomingAppointmentListView extends StatelessWidget {
  const UpcomingAppointmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetUpcomingAppointment,
      builder: (homeLogic) {
        return ListView.builder(
          itemCount: homeLogic.getUpcomingAppointmentModel?.data?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return UpcomingAppointmentBottomSheet(
                      profileImage: homeLogic.getUpcomingAppointmentModel?.data?[index].provider?.profileImage ?? "",
                      providerName: homeLogic.getUpcomingAppointmentModel?.data?[index].provider?.name ?? "",
                      serviceName: homeLogic.getUpcomingAppointmentModel?.data?[index].service?.name ?? "",
                      serviceProviderFee: homeLogic.getUpcomingAppointmentModel?.data?[index].serviceProviderFee.toString() ?? "",
                      rating: homeLogic.getUpcomingAppointmentModel?.data?[index].provider?.avgRating?.toStringAsFixed(1) ?? "",
                      time: homeLogic.getUpcomingAppointmentModel?.data?[index].date ?? "",
                      date: homeLogic.getUpcomingAppointmentModel?.data?[index].time ?? "",
                      providerId: homeLogic.getUpcomingAppointmentModel?.data?[index].provider?.id ?? "",
                      appointmentUniqueId: homeLogic.getUpcomingAppointmentModel?.data?[index].appointmentId ?? "",
                      appointmentId: homeLogic.getUpcomingAppointmentModel?.data?[index].id ?? "",
                      isViewAll: false,
                    );
                  },
                );
              },
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.bookingInformation,
                    arguments: [
                      homeLogic.getUpcomingAppointmentModel?.data?[index].id,
                      AppColors.colorList[index % AppColors.colorList.length],
                      AppColors.textColorList[index % AppColors.textColorList.length],
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
                                imageUrl:
                                    "${ApiConstant.BASE_URL}${homeLogic.getUpcomingAppointmentModel?.data?[index].provider?.profileImage ?? ""}",
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
                                  homeLogic.getUpcomingAppointmentModel?.data?[index].provider?.name ?? "",
                                  style: AppFontStyle.fontStyleW900(
                                    fontSize: 16,
                                    fontColor: AppColors.appButton,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.colorList[index % AppColors.colorList.length],
                                  ),
                                  child: Text(
                                    homeLogic.getUpcomingAppointmentModel?.data?[index].service?.name ?? "",
                                    style: AppFontStyle.fontStyleW600(
                                      fontSize: 12,
                                      fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                                    ),
                                  ),
                                ),
                                Text(
                                  "$currency ${homeLogic.getUpcomingAppointmentModel?.data?[index].serviceProviderFee ?? ""}",
                                  style: AppFontStyle.fontStyleW800(
                                    fontSize: 18,
                                    fontColor: AppColors.primaryAppColor1,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset(AppAsset.icStarFilled, height: 14),
                                    Text(
                                      "  ${homeLogic.getUpcomingAppointmentModel?.data?[index].provider?.avgRating?.toStringAsFixed(1) ?? ""}",
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
                              homeLogic.getUpcomingAppointmentModel?.data?[index].appointmentId ?? "",
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
                                  homeLogic.getUpcomingAppointmentModel?.data?[index].time ?? "",
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
                                  homeLogic.getUpcomingAppointmentModel?.data?[index].date ?? "",
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
                                            appointmentId: homeLogic.getUpcomingAppointmentModel?.data?[index].id ?? "",
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
                          GetBuilder<AppointmentScreenController>(
                            id: Constant.idGetAllAppointment,
                            builder: (logic) {
                              return Expanded(
                                child: PrimaryAppButton(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes.schedule,
                                      arguments: [
                                        homeLogic.getUpcomingAppointmentModel?.data?[index].provider?.profileImage,
                                        homeLogic.getUpcomingAppointmentModel?.data?[index].provider?.name,
                                        homeLogic.getUpcomingAppointmentModel?.data?[index].service?.name,
                                        homeLogic.getUpcomingAppointmentModel?.data?[index].serviceProviderFee.toString(),
                                        homeLogic.getUpcomingAppointmentModel?.data?[index].provider?.avgRating
                                            ?.toStringAsFixed(1),
                                        homeLogic.getUpcomingAppointmentModel?.data?[index].date,
                                        homeLogic.getUpcomingAppointmentModel?.data?[index].time,
                                        homeLogic.getUpcomingAppointmentModel?.data?[index].provider?.id,
                                        AppColors.colorList[index % AppColors.colorList.length],
                                        AppColors.textColorList[index % AppColors.textColorList.length],
                                        homeLogic.getUpcomingAppointmentModel?.data?[index].id,
                                      ],
                                    )?.then(
                                      (value) async {
                                        await homeLogic.getUpcomingAppointmentApiCall();
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
                ).paddingOnly(left: 12, right: 12, bottom: 10),
              ),
            );
          },
        ).paddingOnly(top: 10);
      },
    );
  }
}
