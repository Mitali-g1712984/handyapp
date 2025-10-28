import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/dialog/select_date_dialog.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/appointment_screen/model/get_all_appointment_model.dart';
import 'package:handy/ui/my_appointment_screen/controller/my_appointment_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class MyAppointmentAppBarView extends StatelessWidget {
  const MyAppointmentAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "My Booked Appointment",
      showLeadingIcon: true,
    );
  }
}

/// =================== Title =================== ///
class MyAppointmentTitleView extends StatelessWidget {
  const MyAppointmentTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          EnumLocale.txtAppointmentDetails.name.tr,
          style: AppFontStyle.fontStyleW800(
            fontSize: 17,
            fontColor: AppColors.appButton,
          ),
        ),
        GetBuilder<MyAppointmentController>(
          id: Constant.idSelectDateRange,
          builder: (logic) {
            return GestureDetector(
              onTap: () {
                Get.dialog(
                  Dialog(
                    backgroundColor: AppColors.transparent,
                    surfaceTintColor: AppColors.transparent,
                    shadowColor: AppColors.transparent,
                    elevation: 0,
                    child: const SelectDateDialog(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      logic.startDateFormatted == null ? "ALL" : "${logic.startDateFormatted} TO\n${logic.endDateFormatted}",
                      style: AppFontStyle.fontStyleW700(
                        fontSize: 12,
                        fontColor: AppColors.tabUnselectText,
                      ),
                    ).paddingOnly(right: 5),
                    Image.asset(
                      AppAsset.icArrowDown,
                      height: 22,
                      color: AppColors.tabUnselectText,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ).paddingAll(15);
  }
}

/// =================== List View =================== ///
class MyAppointmentListView extends StatelessWidget {
  const MyAppointmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppointmentController>(
      id: Constant.idGetAllAppointment,
      builder: (logic) {
        return logic.getMyAppointment.isEmpty
            ? logic.isLoading
                ? Shimmers.appointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onRefresh(),
                color: AppColors.primaryAppColor1,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getMyAppointment.length,
                        controller: logic.scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getMyAppointment.length,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: MyAppointmentListItemView(
                                  index: index,
                                  getAllAppointmentData: logic.getMyAppointment[index],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    logic.isLoading1
                        ? CircularProgressIndicator(
                            color: AppColors.primaryAppColor1,
                          ).paddingOnly(bottom: 10)
                        : const SizedBox()
                  ],
                ),
              );
      },
    );
  }
}

class MyAppointmentListItemView extends StatelessWidget {
  final int index;
  final GetAllAppointmentData getAllAppointmentData;

  const MyAppointmentListItemView({super.key, required this.index, required this.getAllAppointmentData});

  Color getServiceBgColor() {
    String imageUrl = getAllAppointmentData.serviceImage ?? "";
    int hash = imageUrl.hashCode.abs();
    return AppColors.colorList[hash % AppColors.colorList.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.bookingInformation,
          arguments: [
            getAllAppointmentData.id,
          ],
        );
      },
      child: Container(
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
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: getServiceBgColor(),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${getAllAppointmentData.serviceImage}",
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icPlaceholderService).paddingAll(20);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icPlaceholderService).paddingAll(20);
                      },
                    ),
                  ),
                ),
                SizedBox(width: Get.width * 0.02),
                SizedBox(
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            getAllAppointmentData.appointmentId ?? "",
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 12,
                              fontColor: AppColors.tabUnselectText,
                            ),
                          ),
                          const SizedBox(width: 10),
                          getAllAppointmentData.package?.packageName?.isEmpty == true ||
                                  getAllAppointmentData.package?.packageName == null
                              ? const SizedBox()
                              : Container(
                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColors.colorList[index % AppColors.colorList.length],
                                  ),
                                  child: Text(
                                    "Package",
                                    style: AppFontStyle.fontStyleW600(
                                      fontSize: 12,
                                      fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                                    ),
                                  ),
                                ),
                          getAllAppointmentData.addOnService?.isEmpty == true || getAllAppointmentData.addOnService == null
                              ? const SizedBox()
                              : Container(
                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColors.colorList[index % AppColors.colorList.length],
                                  ),
                                  child: Text(
                                    "Add-ons",
                                    style: AppFontStyle.fontStyleW600(
                                      fontSize: 12,
                                      fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        width: Get.width * 0.55,
                        child: Text(
                          getAllAppointmentData.serviceName ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.fontStyleW800(
                            fontSize: 16,
                            fontColor: AppColors.appButton,
                          ),
                        ),
                      ),
                      Text(
                        "$currency ${getAllAppointmentData.serviceProviderFee}",
                        style: AppFontStyle.fontStyleW700(
                          fontSize: 17,
                          fontColor: AppColors.primaryAppColor1,
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 5, bottom: 5),
                ),
              ],
            ).paddingOnly(left: 7, right: 10),
            Container(
              decoration: BoxDecoration(
                color: AppColors.couponBox.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Date & Time",
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 13,
                          fontColor: AppColors.grey,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${getAllAppointmentData.date}, ${getAllAppointmentData.time}",
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 14,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 7, bottom: 7),
                  getAllAppointmentData.agencyApproval == 1 && getAllAppointmentData.providerName?.isEmpty == true
                      ? const SizedBox()
                      : Divider(
                          height: 3,
                          color: AppColors.grey.withOpacity(0.1),
                        ).paddingOnly(top: 7, bottom: 7),
                  getAllAppointmentData.providerName?.isEmpty == true
                      ? const SizedBox()
                      : Row(
                          children: [
                            Text(
                              "Provider",
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 13,
                                fontColor: AppColors.grey,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.greyText.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                imageUrl: "${ApiConstant.BASE_URL}${getAllAppointmentData.providerProfileImage}",
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(7);
                                },
                                errorWidget: (context, url, error) {
                                  return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(7);
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              getAllAppointmentData.providerName ?? "",
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 14,
                                fontColor: AppColors.appButton,
                              ),
                            ),
                          ],
                        ),
                  getAllAppointmentData.agencyApproval == 1
                      ? PrimaryAppButton(
                          color: AppColors.cancellationBox,
                          text: "Waiting for agency approval",
                          textStyle: AppFontStyle.fontStyleW800(
                            fontSize: 15,
                            fontColor: AppColors.redBox,
                          ),
                        ).paddingAll(15)
                      : getAllAppointmentData.status == 2
                          ? const SizedBox()
                          : PrimaryAppButton(
                              color: getAllAppointmentData.status == 1
                                  ? AppColors.divider
                                  : getAllAppointmentData.status == 3
                                      ? AppColors.completedBox
                                      : AppColors.cancellationBox,
                              text: getAllAppointmentData.status == 1
                                  ? EnumLocale.desThisAppointmentPending.name.tr
                                  : getAllAppointmentData.status == 3
                                      ? EnumLocale.desThisAppointmentCompleted.name.tr
                                      : EnumLocale.desThisAppointmentCancelled.name.tr,
                              textStyle: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: getAllAppointmentData.status == 1
                                    ? AppColors.tabUnselectText
                                    : getAllAppointmentData.status == 3
                                        ? AppColors.primaryAppColor1
                                        : AppColors.redBox,
                              ),
                            ).paddingOnly(top: 15, bottom: 15),
                ],
              ),
            ).paddingOnly(top: 12),
            getAllAppointmentData.status == 2
                ? Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          shape: BoxShape.circle,
                        ),
                      ).paddingOnly(right: 5),
                      Text(
                        "Work in progress",
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 12,
                          fontColor: AppColors.green,
                        ),
                      ),
                    ],
                  ).paddingOnly(left: 15, top: 10)
                : getAllAppointmentData.agencyApproval == 1
                    ? Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: AppColors.redBox,
                              shape: BoxShape.circle,
                            ),
                          ).paddingOnly(right: 5),
                          Text(
                            "Waiting for agency approval",
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 12,
                              fontColor: AppColors.redBox,
                            ),
                          ),
                        ],
                      ).paddingOnly(left: 15, top: 10)
                    : const SizedBox(),
          ],
        ).paddingOnly(top: 7, bottom: 7),
      ).paddingOnly(left: 12, right: 12, bottom: 10),
    );
  }
}
