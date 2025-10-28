import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/date_time_picker/src/properties/date_formatter.dart';
import 'package:handy/custom/date_time_picker/src/properties/day_style.dart';
import 'package:handy/custom/date_time_picker/src/properties/easy_day_props.dart';
import 'package:handy/custom/date_time_picker/src/properties/easy_header_props.dart';
import 'package:handy/custom/date_time_picker/src/widgets/easy_date_timeline_widget/easy_date_timeline_widget.dart';
import 'package:handy/custom/title/custom_title.dart';
import 'package:handy/ui/re_schedule_screen/controller/re_schedule_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/shimmers.dart';
import 'package:handy/utils/utils.dart';
import 'package:intl/intl.dart';

/// =================== App Bar =================== ///
class ReScheduleAppBarView extends StatelessWidget {
  const ReScheduleAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtReSchedule.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Information =================== ///
class ReScheduleInfoView extends StatelessWidget {
  const ReScheduleInfoView({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: GetBuilder<ReScheduleController>(
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
                    imageUrl: "${ApiConstant.BASE_URL}${logic.providerProfileImage}",
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
                      logic.providerName ?? "",
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
                        logic.serviceName ?? "",
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 12,
                          fontColor: logic.textColor ?? AppColors.primaryAppColor1,
                        ),
                      ),
                    ),
                    Text(
                      "$currency ${logic.serviceProviderFee}",
                      style: AppFontStyle.fontStyleW800(
                        fontSize: 18,
                        fontColor: AppColors.primaryAppColor1,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(AppAsset.icStarFilled, height: 14),
                        Text(
                          "  ${logic.providerAvgRating}",
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

/// =================== Select Date =================== ///
class ReScheduleDateView extends StatelessWidget {
  const ReScheduleDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtSelectDateTime.name.tr,
          style: AppFontStyle.fontStyleW900(
            fontSize: 16,
            fontColor: AppColors.appButton,
          ),
        ).paddingOnly(left: 12),
        GetBuilder<ReScheduleController>(
          builder: (logic) {
            return EasyDateTimeLine(
              initialDate: DateFormat("yyyy-MM-dd").parse(logic.date ?? ""),
              disabledDates: logic.getDisabledDates(),
              onDateChange: (selectedDate) async {
                logic.selectedDate = selectedDate;
                logic.formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                logic.date = DateFormat('yyyy-MM-dd').format(selectedDate);

                log("Selected Date :: ${logic.selectedDate}");

                await logic.getAppointmentTimeApiCall(
                  agencyId: logic.agencyId ?? "",
                  date: logic.formattedDate ?? "",
                  serviceId: logic.serviceId ?? "",
                );

                logic.onGetSlotsList();
                logic.onBookedSlot();

                if (logic.formattedDate != logic.date) {
                  logic.selectedSlotsList.clear();
                } else {
                  logic.selectedSlotsList.removeWhere((element) => element != logic.time);

                  log("Then SelectedSlot List :: ${logic.selectedSlotsList}");
                }
              },
              headerProps: EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                showMonthPicker: true,
                dateFormatter: const DateFormatter.fullDateDMonthAsStrY(),
                monthStyle: AppFontStyle.fontStyleW700(
                  fontColor: AppColors.title,
                  fontSize: 15,
                ),
                selectedDateStyle: AppFontStyle.fontStyleW700(
                  fontColor: AppColors.appButton,
                  fontSize: 15,
                ),
              ),
              dayProps: EasyDayProps(
                height: 75,
                width: 60,
                borderColor: Colors.transparent,
                todayHighlightColor: Colors.transparent,
                dayStructure: DayStructure.dayStrDayNum,
                disabledDayStyle: DayStyle(
                  dayNumStyle: AppFontStyle.fontStyleW700(
                    fontColor: AppColors.disableSlotText,
                    fontSize: 15,
                  ),
                  dayStrStyle: AppFontStyle.fontStyleW700(
                    fontColor: AppColors.disableSlotText,
                    fontSize: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.disableSlot,
                  ),
                ),
                todayStyle: DayStyle(
                  dayNumStyle: AppFontStyle.fontStyleW700(
                    fontColor: AppColors.tabUnselectText,
                    fontSize: 15,
                  ),
                  dayStrStyle: AppFontStyle.fontStyleW700(
                    fontColor: AppColors.tabUnselectText,
                    fontSize: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.divider,
                  ),
                ),
                activeDayStyle: DayStyle(
                  dayNumStyle: AppFontStyle.fontStyleW700(
                    fontColor: AppColors.white,
                    fontSize: 15,
                  ),
                  dayStrStyle: AppFontStyle.fontStyleW700(
                    fontColor: AppColors.white,
                    fontSize: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.primaryAppColor1,
                  ),
                ),
                inactiveDayStyle: DayStyle(
                  dayNumStyle: AppFontStyle.fontStyleW700(
                    fontColor: AppColors.tabUnselectText,
                    fontSize: 15,
                  ),
                  dayStrStyle: AppFontStyle.fontStyleW700(
                    fontColor: AppColors.tabUnselectText,
                    fontSize: 15,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ).paddingOnly(left: 5, right: 12, bottom: 12);
          },
        ),
      ],
    );
  }
}

/// =================== Timer Slot =================== ///
class ReScheduleSlotView extends StatelessWidget {
  const ReScheduleSlotView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReScheduleController>(
      id: Constant.idGetAppointmentTime,
      builder: (logic) {
        return Column(
          children: [
            CustomTitle(
              title: EnumLocale.txtMorningSession.name.tr,
              method: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppColors.timerSlotBg,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.08),
                      offset: const Offset(
                        0.5,
                        0.8,
                      ),
                      blurRadius: 3.0,
                      spreadRadius: 0.2,
                    ),
                  ],
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: !(logic.hasMorningSlots) ? false : true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          logic.serviceStartTime ?? "--",
                          style: AppFontStyle.fontStyleW800(
                            fontSize: 16,
                            fontColor: AppColors.appButton,
                          ),
                        ),
                        Text(
                          "TO",
                          style: AppFontStyle.fontStyleW800(
                            fontSize: 16,
                            fontColor: AppColors.categoryText,
                          ),
                        ),
                        Text(
                          logic.serviceBreakStartTime ?? "--",
                          style: AppFontStyle.fontStyleW800(
                            fontSize: 16,
                            fontColor: AppColors.appButton,
                          ),
                        ),
                      ],
                    ).paddingOnly(right: 12),
                    trailing: Image.asset(
                      AppAsset.icArrowDown,
                      height: 25,
                      width: 25,
                      color: AppColors.categoryText,
                    ),
                    children: [
                      GetBuilder<ReScheduleController>(
                        builder: (logic) {
                          return Container(
                            width: Get.width,
                            color: AppColors.white,
                            child: logic.isLoading
                                ? Shimmers.selectSlotShimmer()
                                : buildSlotCategory(
                                    logic.morningSlots,
                                    logic.formattedDate.toString(),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ).paddingOnly(top: 5, bottom: 20),
            CustomTitle(
              title: EnumLocale.txtAfternoonSession.name.tr,
              method: logic.getAppointmentTimeModel?.eveningSlots?.isEmpty == true
                  ? const SizedBox()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AppColors.timerSlotBg,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.08),
                            offset: const Offset(
                              0.5,
                              0.8,
                            ),
                            blurRadius: 3.0,
                            spreadRadius: 0.2,
                          ),
                        ],
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
                        child: ExpansionTile(
                          initiallyExpanded: (logic.hasMorningSlots) ? true : false,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                logic.serviceBreakEndTime ?? "--",
                                style: AppFontStyle.fontStyleW800(
                                  fontSize: 17,
                                  fontColor: AppColors.appButton,
                                ),
                              ),
                              Text(
                                "TO",
                                style: AppFontStyle.fontStyleW800(
                                  fontSize: 17,
                                  fontColor: AppColors.categoryText,
                                ),
                              ),
                              Text(
                                logic.serviceEndTime ?? "--",
                                style: AppFontStyle.fontStyleW800(
                                  fontSize: 17,
                                  fontColor: AppColors.appButton,
                                ),
                              ),
                            ],
                          ).paddingOnly(right: 12),
                          trailing: Image.asset(
                            AppAsset.icArrowDown,
                            height: 25,
                            width: 25,
                            color: AppColors.categoryText,
                          ),
                          children: [
                            GetBuilder<ReScheduleController>(
                              builder: (logic) {
                                return Container(
                                  width: Get.width,
                                  color: AppColors.white,
                                  child: logic.isLoading
                                      ? Shimmers.selectSlotShimmer()
                                      : buildSlotCategory(
                                          logic.afternoonSlots,
                                          logic.formattedDate.toString(),
                                        ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ).paddingAll(15);
      },
    );
  }
}

Widget buildSlotCategory(List<String> slots, String selectedDate) {
  ReScheduleController reScheduleController = Get.find<ReScheduleController>();

  reScheduleController.hasMorningSlots = slots.any((slot) {
    DateTime currentTime = DateTime.now();
    DateTime currentDate = DateTime.now();
    DateTime slotDateTime = DateFormat('yyyy-MM-dd').parse(selectedDate);

    DateTime currentTimeWithDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      currentTime.hour,
      currentTime.minute,
    );

    DateTime slotTime = DateFormat('hh:mm a').parse(slot);
    DateTime slotTimeWithDate = DateTime(
      slotDateTime.year,
      slotDateTime.month,
      slotDateTime.day,
      slotTime.hour,
      slotTime.minute,
    );

    return !currentDate.isAfter(slotDateTime) || !currentTimeWithDate.isAfter(slotTimeWithDate);
  });

  return SafeArea(
    child: GetBuilder<ReScheduleController>(
      id: Constant.idUpdateSlots,
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimationLimiter(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.6,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 0.10,
                ),
                itemCount: slots.length,
                itemBuilder: (context, index) {
                  DateTime currentTime = DateTime.now();
                  DateTime currentDate = DateTime.now();
                  DateTime slotDateTime = DateFormat('yyyy-MM-dd').parse(selectedDate);

                  DateTime currentTimeWithDate = DateTime(currentDate.year, currentDate.month,
                      currentDate.day, currentTime.hour, currentTime.minute);

                  DateTime slotTime = DateFormat('hh:mm a').parse(slots[index]);
                  DateTime slotTimeWithDate = DateTime(slotDateTime.year, slotDateTime.month,
                      slotDateTime.day, slotTime.hour, slotTime.minute);

                  List<String>? timeSlots = logic.getAppointmentTimeModel?.busySlots;

                  bool isSlotBooked = timeSlots != null && timeSlots.contains(slots[index]);
                  bool isSelected = logic.selectedSlotsList.contains(slots[index]);

                  bool isSlotTimePassed = currentDate.isAfter(slotDateTime) &&
                      currentTimeWithDate.isAfter(slotTimeWithDate);

                  logic.isFirstTap = true;

                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 400),
                    columnCount: slots.length,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            if (isSlotBooked) {
                              if (logic.isFirstTap) {
                                logic.isFirstTap = false;
                                Utils.showToast(
                                    Get.context!, "This time is already booked for this agency");
                                Future.delayed(
                                  const Duration(seconds: 5),
                                  () {
                                    logic.isFirstTap = true;
                                  },
                                );
                              }
                            } else if (isSlotTimePassed) {
                              if (logic.isFirstTap) {
                                logic.isFirstTap = false;
                                Utils.showToast(Get.context!, EnumLocale.toastPreviousTime.name.tr);
                                Future.delayed(
                                  const Duration(seconds: 5),
                                  () {
                                    logic.isFirstTap = true;
                                  },
                                );
                              }
                            } else {
                              if (logic.isFirstTap) {
                                logic.isFirstTap = false;

                                logic.selectSlot(slots[index]);
                                log("Select Slot Time :: ${logic.selectedSlotsList}");

                                /// if already booked slot within selected slot
                                List selectSlot = logic.selectedSlotsList;
                                List<String>? alreadyBookedSlot =
                                    logic.getAppointmentTimeModel?.busySlots;

                                List commonElements = selectSlot
                                    .toSet()
                                    .intersection(alreadyBookedSlot!.toSet())
                                    .toList();

                                log("Booked Slot is :: ${logic.getAppointmentTimeModel?.busySlots}");
                                log("Select Slot is :::: ${logic.selectedSlotsList}");
                                log("Common element :: $commonElements");

                                if (commonElements.isNotEmpty) {
                                  Utils.showToast(
                                      Get.context!, EnumLocale.toastInvalidTime.name.tr);
                                }

                                /// if already booked slot within break time
                                List slotSelected = logic.selectedSlotsList;
                                String breakTimes = logic.serviceStartTime?.trim() ?? "";

                                if (slotSelected.contains(breakTimes)) {
                                  Utils.showToast(
                                      Get.context!, EnumLocale.toastInvalidTime.name.tr);
                                }

                                Future.delayed(
                                  const Duration(seconds: 5),
                                  () {
                                    logic.isFirstTap = true;
                                  },
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 3, right: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? isSlotBooked
                                        ? AppColors.divider
                                        : AppColors.primaryAppColor1
                                    : isSlotTimePassed || isSlotBooked
                                        ? AppColors.disableSlot
                                        : AppColors.divider,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  slots[index],
                                  style: AppFontStyle.fontStyleW700(
                                    fontColor: isSelected
                                        ? isSlotBooked
                                            ? AppColors.tabUnselectText
                                            : AppColors.white
                                        : isSlotTimePassed || isSlotBooked
                                            ? AppColors.disableSlotText
                                            : AppColors.tabUnselectText,
                                    fontSize: 13,
                                    textDecoration: isSlotBooked || isSlotTimePassed
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    decorationColor: AppColors.disableSlotText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    ),
  );
}

/// =================== Bottom View =================== ///
class ReScheduleBottomView extends StatelessWidget {
  const ReScheduleBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.085,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(
              3.0,
              3.0,
            ),
            blurRadius: 8.0,
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: GetBuilder<ReScheduleController>(
        builder: (logic) {
          return PrimaryAppButton(
            onTap: () {
              logic.onReScheduleClick();
            },
            text: EnumLocale.txtReSchedule.name.tr,
            textStyle: AppFontStyle.fontStyleW800(
              fontSize: 17,
              fontColor: AppColors.primaryAppColor1,
            ),
          );
        },
      ),
    );
  }
}
