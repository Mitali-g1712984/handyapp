import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/dialog/cancel_appointment_dialog.dart';
import 'package:handy/custom/dialog/review_dialog.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/appointment_screen/controller/appointment_screen_controller.dart';
import 'package:handy/ui/appointment_screen/model/get_all_appointment_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class AppointmentAppBarView extends StatelessWidget {
  const AppointmentAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyBooking.name.tr,
      showLeadingIcon: false,
    );
  }
}

/// =================== Tab Bar =================== ///
class AppointmentTabView extends StatelessWidget {
  const AppointmentTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtViewAppointment.name.tr,
          style: AppFontStyle.fontStyleW900(
            fontSize: 18,
            fontColor: AppColors.appButton,
          ),
        ).paddingOnly(top: 15, left: 15, bottom: 7),
        const AppointmentTabBarView().paddingOnly(bottom: 10),
        const AppointmentTabBarItemView(),
      ],
    );
  }
}

class AppointmentTabBarView extends StatelessWidget {
  const AppointmentTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Tab(text: EnumLocale.txtPendingAppointment.name.tr),
      Tab(text: EnumLocale.txtCancelledAppointment.name.tr),
      Tab(text: EnumLocale.txtCompletedAppointment.name.tr),
    ];

    return GetBuilder<AppointmentScreenController>(
      builder: (logic) {
        return TabBar(
          controller: logic.tabController,
          tabs: tabs,
          labelStyle: AppFontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.white,
          ),
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          indicatorPadding: const EdgeInsets.all(5),
          indicator: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.appButton),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.white,
          unselectedLabelStyle: AppFontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.tabUnselectText,
          ),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
        );
      },
    );
  }
}

class AppointmentTabBarItemView extends StatelessWidget {
  const AppointmentTabBarItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      builder: (logic) {
        return Expanded(
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: logic.tabController,
            children: const [
              PendingAppointment(),
              CancelAppointment(),
              CompleteAppointment(),
            ],
          ),
        );
      },
    );
  }
}

/// =================== Pending Appointment =================== ///
class PendingAppointment extends StatelessWidget {
  const PendingAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      id: Constant.idGetAllAppointment,
      builder: (logic) {
        return logic.getPending.isEmpty
            ? logic.isLoading
                ? Shimmers.appointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundPendingAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                color: AppColors.primaryAppColor1,
                onRefresh: () => logic.onPendingRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getPending.length,
                        controller: logic.pendingScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getPending.length,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: PendingAppointmentListItemView(
                                  index: index,
                                  getAllPendingAppointmentData: logic.getPending[index],
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

class PendingAppointmentListItemView extends StatelessWidget {
  final int index;
  final GetAllAppointmentData getAllPendingAppointmentData;

  const PendingAppointmentListItemView({
    super.key,
    required this.index,
    required this.getAllPendingAppointmentData,
  });

  Color getServiceBgColor() {
    String imageUrl = getAllPendingAppointmentData.serviceImage ?? "";
    int hash = imageUrl.hashCode.abs(); // Ensure positive value
    return AppColors.colorList[hash % AppColors.colorList.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.bookingInformation,
          arguments: [
            getAllPendingAppointmentData.id,
          ],
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            width: 1,
            color: AppColors.grey.withOpacity(0.15),
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
                      imageUrl: "${ApiConstant.BASE_URL}${getAllPendingAppointmentData.serviceImage}",
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
                            getAllPendingAppointmentData.appointmentId ?? "",
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 12,
                              fontColor: AppColors.tabUnselectText,
                            ),
                          ),
                          const SizedBox(width: 10),
                          getAllPendingAppointmentData.package?.packageName?.isEmpty == true ||
                                  getAllPendingAppointmentData.package?.packageName == null
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
                          getAllPendingAppointmentData.addOnService?.isEmpty == true ||
                                  getAllPendingAppointmentData.addOnService == null
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
                          getAllPendingAppointmentData.serviceName ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.fontStyleW800(
                            fontSize: 16,
                            fontColor: AppColors.appButton,
                          ),
                        ),
                      ),
                      Text(
                        "$currency ${getAllPendingAppointmentData.serviceProviderFee}",
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
                color: AppColors.divider,
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
                        "${getAllPendingAppointmentData.date}, ${getAllPendingAppointmentData.time}",
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 14,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 7, bottom: 7),
                  getAllPendingAppointmentData.agencyApproval == 1
                      ? const SizedBox()
                      : getAllPendingAppointmentData.agencyApproval == 2 &&
                              getAllPendingAppointmentData.providerName?.isEmpty == true
                          ? const SizedBox()
                          : Divider(
                              height: 3,
                              color: AppColors.grey.withOpacity(0.1),
                            ).paddingOnly(top: 7, bottom: 7),
                  getAllPendingAppointmentData.providerName?.isEmpty == true
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
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: AppColors.greyText.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                imageUrl: "${ApiConstant.BASE_URL}${getAllPendingAppointmentData.providerProfileImage}",
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
                              getAllPendingAppointmentData.providerName ?? "",
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 14,
                                fontColor: AppColors.appButton,
                              ),
                            ),
                          ],
                        ).paddingOnly(top: 5, bottom: 5),
                ],
              ),
            ).paddingOnly(top: 12),
            GetBuilder<AppointmentScreenController>(
              id: Constant.idGetAllAppointment,
              builder: (logic) {
                return getAllPendingAppointmentData.status == 1 &&
                        getAllPendingAppointmentData.agencyApproval == 2 &&
                        getAllPendingAppointmentData.providerName?.isNotEmpty == true
                    ? Row(
                        children: [
                          Expanded(
                            child: PrimaryAppButton(
                              height: 48,
                              borderRadius: 10,
                              color: AppColors.redBox,
                              text: "Cancel Appointment",
                              textStyle: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.white,
                              ),
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
                                            appointmentId: getAllPendingAppointmentData.id ?? "",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: PrimaryAppButton(
                              height: 48,
                              borderRadius: 10,
                              color: AppColors.primaryAppColor1,
                              text: "Re-Schedule",
                              textStyle: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.white,
                              ),
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.schedule,
                                  arguments: [
                                    getAllPendingAppointmentData.providerProfileImage,
                                    getAllPendingAppointmentData.providerName,
                                    getAllPendingAppointmentData.serviceName,
                                    getAllPendingAppointmentData.serviceProviderFee.toString(),
                                    getAllPendingAppointmentData.agencyavgRating,
                                    getAllPendingAppointmentData.date,
                                    getAllPendingAppointmentData.time,
                                    getAllPendingAppointmentData.providerName,
                                    AppColors.colorList[index % AppColors.colorList.length],
                                    AppColors.textColorList[index % AppColors.textColorList.length],
                                    getAllPendingAppointmentData.id,
                                    getAllPendingAppointmentData.serviceId,
                                    getAllPendingAppointmentData.agency,
                                  ],
                                )?.then(
                                  (value) async {
                                    logic.startPending = 1;
                                    logic.getPending = [];

                                    await logic.getAllAppointmentApiCall(
                                      customerId: Constant.storage.read("customerId"),
                                      status: "1",
                                      start: logic.startPending.toString(),
                                      limit: logic.limitPending.toString(),
                                      startDate: 'All',
                                      endDate: 'All',
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ).paddingOnly(top: 15, bottom: 5, left: 12, right: 12)
                    : getAllPendingAppointmentData.status == 1 && getAllPendingAppointmentData.agencyApproval == 2
                        ? PrimaryAppButton(
                            height: 48,
                            borderRadius: 10,
                            color: AppColors.redBox,
                            text: "Cancel Appointment",
                            textStyle: AppFontStyle.fontStyleW800(
                              fontSize: 15,
                              fontColor: AppColors.white,
                            ),
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
                                          appointmentId: getAllPendingAppointmentData.id ?? "",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ).paddingOnly(top: 15, bottom: 5, left: 12, right: 12)
                        : getAllPendingAppointmentData.agencyApproval == 1 &&
                                getAllPendingAppointmentData.providerName?.isNotEmpty == true
                            ? PrimaryAppButton(
                                height: 48,
                                borderRadius: 10,
                                color: AppColors.primaryAppColor1,
                                text: "Re-Schedule",
                                textStyle: AppFontStyle.fontStyleW800(
                                  fontSize: 15,
                                  fontColor: AppColors.white,
                                ),
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.schedule,
                                    arguments: [
                                      getAllPendingAppointmentData.providerProfileImage,
                                      getAllPendingAppointmentData.providerName,
                                      getAllPendingAppointmentData.serviceName,
                                      getAllPendingAppointmentData.serviceProviderFee.toString(),
                                      getAllPendingAppointmentData.agencyavgRating,
                                      getAllPendingAppointmentData.date,
                                      getAllPendingAppointmentData.time,
                                      getAllPendingAppointmentData.providerName,
                                      AppColors.colorList[index % AppColors.colorList.length],
                                      AppColors.textColorList[index % AppColors.textColorList.length],
                                      getAllPendingAppointmentData.id,
                                      getAllPendingAppointmentData.serviceId,
                                      getAllPendingAppointmentData.agency,
                                    ],
                                  )?.then(
                                    (value) async {
                                      logic.startPending = 1;
                                      logic.getPending = [];

                                      await logic.getAllAppointmentApiCall(
                                        customerId: Constant.storage.read("customerId"),
                                        status: "1",
                                        start: logic.startPending.toString(),
                                        limit: logic.limitPending.toString(),
                                        startDate: 'All',
                                        endDate: 'All',
                                      );
                                    },
                                  );
                                },
                              ).paddingOnly(top: 15, bottom: 5, left: 12, right: 12)
                            : const SizedBox();
              },
            ),
            getAllPendingAppointmentData.status == 2
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
                : getAllPendingAppointmentData.agencyApproval == 1
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

/// =================== Cancel Appointment =================== ///
class CancelAppointment extends StatelessWidget {
  const CancelAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      id: Constant.idGetAllAppointment,
      builder: (logic) {
        return logic.getCancel.isEmpty
            ? logic.isLoading
                ? Shimmers.appointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundCancelAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onCancelRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getCancel.length,
                        controller: logic.cancelScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getCancel.length,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: CancelAppointmentListItemView(
                                  index: index,
                                  getAllCancelAppointmentData: logic.getCancel[index],
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

class CancelAppointmentListItemView extends StatelessWidget {
  final int index;
  final GetAllAppointmentData getAllCancelAppointmentData;

  const CancelAppointmentListItemView({
    super.key,
    required this.index,
    required this.getAllCancelAppointmentData,
  });

  Color getServiceBgColor() {
    String imageUrl = getAllCancelAppointmentData.serviceImage ?? "";
    int hash = imageUrl.hashCode.abs(); // Ensure positive value
    return AppColors.colorList[hash % AppColors.colorList.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.bookingInformation,
          arguments: [
            getAllCancelAppointmentData.id,
          ],
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            width: 1,
            color: AppColors.grey.withOpacity(0.15),
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
                      imageUrl: "${ApiConstant.BASE_URL}${getAllCancelAppointmentData.serviceImage}",
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
                            getAllCancelAppointmentData.appointmentId ?? "",
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 12,
                              fontColor: AppColors.tabUnselectText,
                            ),
                          ),
                          const SizedBox(width: 10),
                          getAllCancelAppointmentData.package?.packageName?.isEmpty == true ||
                                  getAllCancelAppointmentData.package?.packageName == null
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
                          getAllCancelAppointmentData.addOnService?.isEmpty == true ||
                                  getAllCancelAppointmentData.addOnService == null
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
                          getAllCancelAppointmentData.serviceName ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.fontStyleW800(
                            fontSize: 16,
                            fontColor: AppColors.appButton,
                          ),
                        ),
                      ),
                      Text(
                        "$currency ${getAllCancelAppointmentData.serviceProviderFee}",
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
              decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(12)),
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
                        "${getAllCancelAppointmentData.date}, ${getAllCancelAppointmentData.time}",
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 14,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 7, bottom: 7),
                  Divider(
                    height: 3,
                    color: AppColors.grey.withOpacity(0.1),
                  ).paddingOnly(top: 7, bottom: 5),
                  getAllCancelAppointmentData.providerName?.isEmpty == true
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
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: AppColors.greyText.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                imageUrl: "${ApiConstant.BASE_URL}${getAllCancelAppointmentData.providerProfileImage}",
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
                              getAllCancelAppointmentData.providerName ?? "",
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 14,
                                fontColor: AppColors.appButton,
                              ),
                            ),
                          ],
                        ).paddingOnly(top: 5, bottom: 5),
                ],
              ),
            ).paddingOnly(top: 12),
            GetBuilder<AppointmentScreenController>(
              id: Constant.idGetAllAppointment,
              builder: (logic) {
                return PrimaryAppButton(
                  height: 48,
                  borderRadius: 10,
                  color: AppColors.cancellationBox.withOpacity(0.4),
                  text: EnumLocale.desThisAppointmentCancelled.name.tr,
                  textStyle: AppFontStyle.fontStyleW800(
                    fontSize: 15,
                    fontColor: AppColors.redBox,
                  ),
                ).paddingOnly(top: 15, bottom: 5);
              },
            ).paddingOnly(left: 12, right: 12),
          ],
        ).paddingOnly(top: 7, bottom: 7),
      ).paddingOnly(left: 12, right: 12, bottom: 10),
    );
  }
}

/// =================== Complete Appointment =================== ///
class CompleteAppointment extends StatelessWidget {
  const CompleteAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      id: Constant.idGetAllAppointment,
      builder: (logic) {
        return logic.getComplete.isEmpty
            ? logic.isLoading
                ? Shimmers.appointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundCompleteAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onCompleteRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getComplete.length,
                        controller: logic.completeScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getComplete.length,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: CompleteAppointmentListItemView(
                                  index: index,
                                  getAllCompleteAppointmentData: logic.getComplete[index],
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

class CompleteAppointmentListItemView extends StatelessWidget {
  final int index;
  final GetAllAppointmentData getAllCompleteAppointmentData;

  const CompleteAppointmentListItemView({super.key, required this.index, required this.getAllCompleteAppointmentData});

  Color getServiceBgColor() {
    String imageUrl = getAllCompleteAppointmentData.serviceImage ?? "";
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
            getAllCompleteAppointmentData.id,
          ],
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            width: 1,
            color: AppColors.grey.withOpacity(0.15),
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
                      imageUrl: "${ApiConstant.BASE_URL}${getAllCompleteAppointmentData.serviceImage}",
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
                            getAllCompleteAppointmentData.appointmentId ?? "",
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 12,
                              fontColor: AppColors.tabUnselectText,
                            ),
                          ),
                          const SizedBox(width: 10),
                          getAllCompleteAppointmentData.package?.packageName?.isEmpty == true ||
                                  getAllCompleteAppointmentData.package?.packageName == null
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
                          getAllCompleteAppointmentData.addOnService?.isEmpty == true ||
                                  getAllCompleteAppointmentData.addOnService == null
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
                          getAllCompleteAppointmentData.serviceName ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.fontStyleW800(
                            fontSize: 16,
                            fontColor: AppColors.appButton,
                          ),
                        ),
                      ),
                      Text(
                        "$currency ${getAllCompleteAppointmentData.serviceProviderFee}",
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
              decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(12)),
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
                        "${getAllCompleteAppointmentData.date}, ${getAllCompleteAppointmentData.time}",
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 14,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 7, bottom: 7),
                  Divider(
                    height: 3,
                    color: AppColors.grey.withOpacity(0.1),
                  ).paddingOnly(top: 7, bottom: 5),
                  getAllCompleteAppointmentData.providerName?.isEmpty == true
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
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: AppColors.greyText.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                imageUrl: "${ApiConstant.BASE_URL}${getAllCompleteAppointmentData.providerProfileImage}",
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
                              getAllCompleteAppointmentData.providerName ?? "",
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 14,
                                fontColor: AppColors.appButton,
                              ),
                            ),
                          ],
                        ).paddingOnly(top: 5, bottom: 5),
                ],
              ),
            ).paddingOnly(top: 12),
            getAllCompleteAppointmentData.isReviewed == true
                ? PrimaryAppButton(
                    height: 40,
                    borderRadius: 8,
                    color: AppColors.completedBox,
                    text: EnumLocale.desThisAppointmentCompleted.name.tr,
                    textStyle: AppFontStyle.fontStyleW800(
                      fontSize: 15,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ).paddingOnly(left: 12, right: 12, top: 10)
                : Row(
                    children: [
                      Expanded(
                        child: PrimaryAppButton(
                          height: 40,
                          borderRadius: 8,
                          color: AppColors.primaryAppColor1,
                          text: "Completed",
                          widget: Image.asset(
                            AppAsset.icVerifyBooking,
                            height: 20,
                          ).paddingOnly(right: 5),
                          overflow: TextOverflow.ellipsis,
                          textStyle: AppFontStyle.fontStyleW800(
                            fontSize: 15,
                            fontColor: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GetBuilder<AppointmentScreenController>(
                        builder: (logic) {
                          return Expanded(
                            child: PrimaryAppButton(
                              onTap: () {
                                Get.dialog(
                                  barrierColor: AppColors.black.withOpacity(0.8),
                                  GetBuilder<AppointmentScreenController>(
                                    id: Constant.idPostReview,
                                    builder: (logic) {
                                      return ProgressDialog(
                                        inAsyncCall: logic.isLoading2,
                                        child: Dialog(
                                          backgroundColor: AppColors.transparent,
                                          shadowColor: Colors.transparent,
                                          surfaceTintColor: Colors.transparent,
                                          elevation: 0,
                                          child: ReviewDialog(
                                            customerId: Constant.storage.read("customerId"),
                                            agencyId: getAllCompleteAppointmentData.agency ?? "",
                                            appointmentId: getAllCompleteAppointmentData.appointmentId ?? "",
                                            serviceId: getAllCompleteAppointmentData.serviceId ?? "",
                                            providerId: getAllCompleteAppointmentData.providerId ?? "",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              height: 40,
                              borderRadius: 8,
                              color: AppColors.rating,
                              text: "Give Review",
                              textStyle: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.ratingBox,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ).paddingOnly(top: 10, left: 12, right: 12),
          ],
        ).paddingOnly(top: 7, bottom: 7),
      ).paddingOnly(left: 12, right: 12, bottom: 10),
    );
  }
}
