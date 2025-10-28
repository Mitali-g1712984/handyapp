import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/booking_information_screen/controller/booking_information_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:intl/intl.dart';

/// =================== App Bar =================== ///
class BookingInfoAppBarView extends StatelessWidget {
  const BookingInfoAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtBookingInformation.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Service Information =================== ///
class BookingInfoServiceView extends StatelessWidget {
  const BookingInfoServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingInformationController>(
      id: Constant.idGetAppointmentInfo,
      builder: (logic) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                offset: const Offset(
                  0.8,
                  0.8,
                ),
                blurRadius: 5.0,
              ),
            ],
            color: AppColors.white,
          ),
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.colorList[0 % AppColors.colorList.length],
                ),
                padding: const EdgeInsets.all(15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: "${ApiConstant.BASE_URL}${logic.getAppointmentInfoModel?.data?.serviceImage}",
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
                    Text(
                      logic.getAppointmentInfoModel?.data?.appointmentId ?? "",
                      style: AppFontStyle.fontStyleW600(
                        fontSize: 12,
                        fontColor: AppColors.tabUnselectText,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.55,
                      child: Text(
                        logic.getAppointmentInfoModel?.data?.serviceName ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.fontStyleW800(
                          fontSize: 16,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                    ),
                    Text(
                      "$currency ${logic.getAppointmentInfoModel?.data?.serviceProviderFee}",
                      style: AppFontStyle.fontStyleW700(
                        fontSize: 17,
                        fontColor: AppColors.primaryAppColor1,
                      ),
                    ),
                  ],
                ).paddingOnly(top: 5, bottom: 5),
              ),
            ],
          ).paddingAll(12),
        );
      },
    );
  }
}

/// =================== Appointment Information =================== ///
class BookingInfoAppointmentView extends StatelessWidget {
  const BookingInfoAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryAppColor1,
          width: 0.7,
        ),
      ),
      child: GetBuilder<BookingInformationController>(
        id: Constant.idGetAppointmentInfo,
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
                        logic.getAppointmentInfoModel?.data?.time ?? "",
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
                        logic.getAppointmentInfoModel?.data?.date ?? "",
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
                ],
              ).paddingOnly(top: 12.5, bottom: 12.5, right: 15, left: 15),
              if (logic.getAppointmentInfoModel?.data?.checkInTime?.isNotEmpty == true &&
                  logic.getAppointmentInfoModel?.data?.checkInTime != null) ...[
                Divider(
                  height: 3,
                  color: AppColors.grey.withOpacity(0.15),
                ),
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
                        AppAsset.icClock,
                        color: AppColors.white,
                      ).paddingAll(10),
                    ).paddingOnly(right: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          logic.getAppointmentInfoModel?.data?.checkInTime ?? "",
                          style: AppFontStyle.fontStyleW900(
                            fontSize: 14,
                            fontColor: AppColors.appButton,
                          ),
                        ),
                        Text(
                          "Check-in Time",
                          style: AppFontStyle.fontStyleW600(
                            fontSize: 12,
                            fontColor: AppColors.categoryText,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    if (logic.getAppointmentInfoModel?.data?.checkOutTime?.isNotEmpty == true &&
                        logic.getAppointmentInfoModel?.data?.checkOutTime != null) ...[
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
                        child: Image.asset(
                          AppAsset.icClock,
                          color: AppColors.white,
                        ).paddingAll(10),
                      ).paddingOnly(right: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            logic.getAppointmentInfoModel?.data?.checkOutTime ?? "",
                            style: AppFontStyle.fontStyleW900(
                              fontSize: 14,
                              fontColor: AppColors.appButton,
                            ),
                          ),
                          Text(
                            "Check-out Time",
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 12,
                              fontColor: AppColors.categoryText,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                    ],
                  ],
                ).paddingOnly(top: 12.5, bottom: 12.5, right: 15, left: 15),
              ],
            ],
          );
        },
      ),
    ).paddingOnly(left: 15, right: 15, bottom: 12);
  }
}

/// =================== Agency-Provider Information =================== ///
class BookingInfoAboutAgencyProviderView extends StatelessWidget {
  const BookingInfoAboutAgencyProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryAppColor1,
          width: 0.7,
        ),
      ),
      child: GetBuilder<BookingInformationController>(
        id: Constant.idGetAppointmentInfo,
        builder: (logic) {
          return Column(
            children: [
              Container(
                height: 45,
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
                    logic.getAppointmentInfoModel?.data?.providerName?.isEmpty == true
                        ? "About Agency"
                        : "About Agency and Provider",
                    style: AppFontStyle.fontStyleW800(
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(left: 15),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greyText.withOpacity(0.2),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${logic.getAppointmentInfoModel?.data?.agencyProfileImage}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icPlaceholderService).paddingAll(20);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icPlaceholderService).paddingAll(20);
                      },
                    ),
                  ).paddingOnly(right: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        logic.getAppointmentInfoModel?.data?.agencyName ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 14,
                          fontColor: AppColors.categoryText,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          logic.makingAgencyMail(email: logic.getAppointmentInfoModel?.data?.agencyEmail ?? "");
                        },
                        child: Text(
                          logic.getAppointmentInfoModel?.data?.agencyEmail ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.fontStyleW500(
                            fontSize: 12,
                            fontColor: AppColors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.personalChat,
                        arguments: [
                          logic.getAppointmentInfoModel?.data?.agency,
                          logic.getAppointmentInfoModel?.data?.agencyName,
                          logic.getAppointmentInfoModel?.data?.agencyProfileImage,
                          "agency",
                        ],
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.message1,
                      ),
                      child: Image.asset(AppAsset.icMessage).paddingAll(8),
                    ),
                  ),
                ],
              ).paddingOnly(top: 13, left: 13, bottom: 13, right: 13),
              logic.getAppointmentInfoModel?.data?.providerName?.isEmpty == true
                  ? const SizedBox()
                  : Divider(
                      height: 3,
                      color: AppColors.grey.withOpacity(0.15),
                    ),
              logic.getAppointmentInfoModel?.data?.providerName?.isEmpty == true
                  ? const SizedBox()
                  : Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greyText.withOpacity(0.2),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                            imageUrl: "${ApiConstant.BASE_URL}${logic.getAppointmentInfoModel?.data?.providerProfileImage}",
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Image.asset(AppAsset.icPlaceholderService).paddingAll(20);
                            },
                            errorWidget: (context, url, error) {
                              return Image.asset(AppAsset.icPlaceholderService).paddingAll(20);
                            },
                          ),
                        ).paddingOnly(right: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              logic.getAppointmentInfoModel?.data?.providerName ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 14,
                                fontColor: AppColors.categoryText,
                              ),
                            ),
                            Text(
                              logic.getAppointmentInfoModel?.data?.providerEmail ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: AppFontStyle.fontStyleW500(
                                fontSize: 12,
                                fontColor: AppColors.grey.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.personalChat,
                              arguments: [
                                logic.getAppointmentInfoModel?.data?.providerId,
                                logic.getAppointmentInfoModel?.data?.providerName,
                                logic.getAppointmentInfoModel?.data?.providerProfileImage,
                                "provider",
                              ],
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.message1,
                            ),
                            child: Image.asset(AppAsset.icMessage).paddingAll(8),
                          ),
                        ),
                      ],
                    ).paddingOnly(top: 13, left: 13, bottom: 13, right: 13),
            ],
          );
        },
      ),
    ).paddingOnly(left: 15, right: 15, bottom: 12);
  }
}

/// =================== AddOn Service Information =================== ///
class BookingInfoAddOnServiceView extends StatelessWidget {
  const BookingInfoAddOnServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryAppColor1,
          width: 0.7,
        ),
      ),
      child: GetBuilder<BookingInformationController>(
        id: Constant.idGetAppointmentInfo,
        builder: (logic) {
          return Column(
            children: [
              Container(
                height: 45,
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
                    "Add-ons",
                    style: AppFontStyle.fontStyleW800(
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(left: 15),
                ),
              ),
              ListView.builder(
                itemCount: logic.getAppointmentInfoModel?.data?.addOnService?.length ?? 0,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl:
                              "${ApiConstant.BASE_URL}${logic.getAppointmentInfoModel?.data?.addOnService?[index].image ?? ""}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            logic.getAppointmentInfoModel?.data?.addOnService?[index].addOnServiceName ?? "",
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 15,
                              fontColor: AppColors.mainTitleText,
                            ),
                          ),
                          Text(
                            "$currency ${logic.getAppointmentInfoModel?.data?.addOnService?[index].price}",
                            style: AppFontStyle.fontStyleW700(
                              fontSize: 15,
                              fontColor: AppColors.primaryAppColor1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).paddingOnly(bottom: 10);
                },
              ).paddingOnly(left: 15, right: 15, top: 15)
            ],
          );
        },
      ),
    ).paddingOnly(left: 15, right: 15, bottom: 12);
  }
}

/// =================== Package Information =================== ///
class BookingInfoPackageView extends StatelessWidget {
  const BookingInfoPackageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryAppColor1,
          width: 0.7,
        ),
      ),
      child: GetBuilder<BookingInformationController>(
        id: Constant.idGetAppointmentInfo,
        builder: (logic) {
          return Column(
            children: [
              Container(
                height: 45,
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
                    "Included in this package",
                    style: AppFontStyle.fontStyleW800(
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(left: 15),
                ),
              ),
              ListView.builder(
                itemCount: logic.getAppointmentInfoModel?.data?.package?.service?.length ?? 0,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greyText.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl:
                              "${ApiConstant.BASE_URL}${logic.getAppointmentInfoModel?.data?.package?.service?[index].image ?? ""}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width * 0.7,
                            child: Text(
                              logic.getAppointmentInfoModel?.data?.package?.service?[index].name ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 14,
                                fontColor: AppColors.mainTitleText,
                              ),
                            ),
                          ),
                          Text(
                            "$currency ${logic.getAppointmentInfoModel?.data?.package?.service?[index].price?.toStringAsFixed(2) ?? ""}",
                            style: AppFontStyle.fontStyleW700(
                              fontSize: 14,
                              fontColor: AppColors.primaryAppColor1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).paddingOnly(left: 13, right: 13, bottom: 13);
                },
              ).paddingOnly(top: 13),
            ],
          );
        },
      ),
    ).paddingOnly(left: 15, right: 15, bottom: 12);
  }
}

/// =================== Payment Information =================== ///
class BookingInfoPaymentView extends StatelessWidget {
  const BookingInfoPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingInformationController>(
      id: Constant.idGetAppointmentInfo,
      builder: (logic) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 0.7,
              color: AppColors.primaryAppColor1,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 45,
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
                    EnumLocale.txtPaymentDescription.name.tr,
                    style: AppFontStyle.fontStyleW800(
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(left: 15),
                ),
              ),

              ///----- without Tax
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.paymentDes,
                ),
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      logic.getAppointmentInfoModel?.data?.package?.service?.isNotEmpty == true
                          ? "Package Price"
                          : EnumLocale.txtConsultingFees.name.tr,
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.fontStyleW600(
                        fontSize: 14,
                        fontColor: AppColors.categoryText,
                      ),
                    ),
                    Text(
                      logic.getAppointmentInfoModel?.data?.package?.service?.isNotEmpty == true
                          ? "$currency ${(logic.packageAmount)}"
                          : "$currency ${(logic.withOutTaxAmount)}",
                      style: AppFontStyle.fontStyleW900(
                        fontSize: 15,
                        fontColor: AppColors.appButton,
                      ),
                    )
                  ],
                ),
              ),

              ///----- If apply coupon (discount)
              logic.getAppointmentInfoModel?.data?.discountAmount == 0 ||
                      logic.getAppointmentInfoModel?.data?.discountAmount == null
                  ? const SizedBox()
                  : Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: AppColors.paymentDes,
                      ),
                      margin: const EdgeInsets.only(bottom: 3),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            EnumLocale.txtDiscount.name.tr,
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 14,
                              fontColor: AppColors.categoryText,
                            ),
                          ),
                          Text(
                            "(-) $currency ${logic.discountAmount}",
                            style: AppFontStyle.fontStyleW900(
                              fontSize: 15,
                              fontColor: AppColors.green,
                            ),
                          )
                        ],
                      ),
                    ),

              ///----- If add on service
              logic.getAppointmentInfoModel?.data?.addOnService?.isEmpty == true
                  ? const SizedBox()
                  : Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: AppColors.paymentDes,
                      ),
                      margin: const EdgeInsets.only(bottom: 3),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Service Add-ons",
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 14,
                              fontColor: AppColors.categoryText,
                            ),
                          ),
                          Text(
                            "(+) $currency ${(logic.addOnServiceAmount)}",
                            style: AppFontStyle.fontStyleW900(
                              fontSize: 15,
                              fontColor: AppColors.appButton,
                            ),
                          )
                        ],
                      ),
                    ),

              ///----- sub total
              logic.getAppointmentInfoModel?.data?.addOnService?.isEmpty == true
                  ? const SizedBox()
                  : Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: AppColors.paymentDes,
                      ),
                      margin: const EdgeInsets.only(bottom: 3),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 14,
                              fontColor: AppColors.categoryText,
                            ),
                          ),
                          Text(
                            "$currency ${(logic.subTotal)}",
                            style: AppFontStyle.fontStyleW900(
                              fontSize: 15,
                              fontColor: AppColors.appButton,
                            ),
                          )
                        ],
                      ),
                    ),

              ///----- tax
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.paymentDes,
                ),
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      EnumLocale.txtTaxCharges.name.tr,
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.fontStyleW600(
                        fontSize: 14,
                        fontColor: AppColors.categoryText,
                      ),
                    ),
                    Text(
                      "(+) $currency ${(logic.taxAmount)}",
                      style: AppFontStyle.fontStyleW900(
                        fontSize: 15,
                        fontColor: AppColors.redBox,
                      ),
                    )
                  ],
                ),
              ),

              ///----- total amount
              Container(
                height: 43,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                  ),
                  color: AppColors.primaryAppColor1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      EnumLocale.txtTotalPayableAmount.name.tr,
                      style: AppFontStyle.fontStyleW600(
                        fontSize: 14,
                        fontColor: AppColors.white,
                      ),
                    ),
                    Text(
                      "$currency ${logic.finalAmount}",
                      style: AppFontStyle.fontStyleW900(
                        fontSize: 15,
                        fontColor: AppColors.white,
                      ),
                    )
                  ],
                ).paddingOnly(left: 15, right: 15),
              ),
            ],
          ),
        ).paddingOnly(left: 15, right: 15);
      },
    );
  }
}

/// =================== Cancel Information =================== ///
class BookingInfoCancelView extends StatelessWidget {
  const BookingInfoCancelView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingInformationController>(
      id: Constant.idGetAppointmentInfo,
      builder: (logic) {
        String timeString = logic.getAppointmentInfoModel?.data?.cancel?.time ?? "";
        DateFormat inputFormat = DateFormat("HH:mm:ss");
        DateTime time = inputFormat.parse(timeString);
        logic.formattedTime = DateFormat('HH:mm').format(time);

        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 0.7,
              color: AppColors.primaryAppColor1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45,
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
                    "Cancellation Reason",
                    style: AppFontStyle.fontStyleW800(
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(left: 15),
                ),
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.paymentDes,
                ),
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reason",
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.fontStyleW600(
                        fontSize: 14,
                        fontColor: AppColors.categoryText,
                      ),
                    ),
                    Text(
                      logic.getAppointmentInfoModel?.data?.cancel?.reason ?? "",
                      style: AppFontStyle.fontStyleW900(
                        fontSize: 15,
                        fontColor: AppColors.appButton,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 35,
                decoration: BoxDecoration(
                  color: AppColors.paymentDes,
                ),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "* Cancelled by ${logic.getAppointmentInfoModel?.data?.cancel?.person == 1 ? "Agency" : logic.getAppointmentInfoModel?.data?.cancel?.person == 2 ? "Customer" : "Provider"} at ${logic.formattedTime}",
                  overflow: TextOverflow.ellipsis,
                  style: AppFontStyle.fontStyleW600(
                    fontSize: 14,
                    fontColor: AppColors.categoryText,
                  ),
                ),
              ),
            ],
          ),
        ).paddingOnly(left: 15, right: 15, top: 15);
      },
    );
  }
}

/// =================== Bottom View =================== ///
class BookingInformationBottomView extends StatelessWidget {
  const BookingInformationBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingInformationController>(
      id: Constant.idGetAppointmentInfo,
      builder: (logic) {
        return logic.getAppointmentInfoModel?.data?.agencyApproval == 1
            ? PrimaryAppButton(
                color: AppColors.cancellationBox,
                text: "Waiting for agency approval",
                textStyle: AppFontStyle.fontStyleW800(
                  fontSize: 15,
                  fontColor: AppColors.redBox,
                ),
              ).paddingAll(15)
            : PrimaryAppButton(
                color: logic.getAppointmentInfoModel?.data?.status == 1
                    ? AppColors.divider
                    : logic.getAppointmentInfoModel?.data?.status == 2
                        ? AppColors.greenBox.withOpacity(0.1)
                        : logic.getAppointmentInfoModel?.data?.status == 3
                            ? AppColors.completedBox
                            : AppColors.cancellationBox,
                text: logic.getAppointmentInfoModel?.data?.status == 1
                    ? EnumLocale.desThisAppointmentPending.name.tr
                    : logic.getAppointmentInfoModel?.data?.status == 2
                        ? "This appointment is in working progress"
                        : logic.getAppointmentInfoModel?.data?.status == 3
                            ? EnumLocale.desThisAppointmentCompleted.name.tr
                            : EnumLocale.desThisAppointmentCancelled.name.tr,
                textStyle: AppFontStyle.fontStyleW800(
                  fontSize: 15,
                  fontColor: logic.getAppointmentInfoModel?.data?.status == 1
                      ? AppColors.tabUnselectText
                      : logic.getAppointmentInfoModel?.data?.status == 2
                          ? AppColors.green
                          : logic.getAppointmentInfoModel?.data?.status == 3
                              ? AppColors.primaryAppColor1
                              : AppColors.redBox,
                ),
              ).paddingAll(15);
      },
    );
  }
}
