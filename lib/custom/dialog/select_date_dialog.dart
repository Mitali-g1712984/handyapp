import 'dart:developer';

import 'package:handy/ui/my_appointment_screen/controller/my_appointment_controller.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SelectDateDialog extends StatelessWidget {
  const SelectDateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppointmentController>(
      id: Constant.idSelectDateRange,
      builder: (logic) {
        return Container(
          height: 480,
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: SfDateRangePicker(
            onSelectionChanged: logic.onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            navigationMode: DateRangePickerNavigationMode.snap,
            startRangeSelectionColor: AppColors.primaryAppColor1,
            endRangeSelectionColor: AppColors.primaryAppColor1,
            showNavigationArrow: true,
            allowViewNavigation: true,
            showActionButtons: true,
            headerHeight: 50,
            cancelText: EnumLocale.txtClose.name.tr,
            confirmText: EnumLocale.txtSubmit.name.tr,
            onCancel: () {
              Get.back();
            },
            onSubmit: (p0) async {
              log("Start date :: ${logic.startDateFormatted}");
              log("End date :: ${logic.endDateFormatted}");

              Get.back();

              logic.getMyAppointment = [];
              logic.startAppointment = 1;

              await logic.getAllAppointmentApiCall(
                customerId: Constant.storage.read("customerId"),
                status: 'All',
                start: logic.startAppointment.toString(),
                limit: logic.limitAppointment.toString(),
                startDate:logic.startDateFormatted == null ?  'All' : (logic.startDateFormatted ?? ""),
                endDate:logic.endDateFormatted == null ?  'All' : (logic.endDateFormatted ?? ""),
              );
            },
            selectionTextStyle: AppFontStyle.fontStyleW600(
              fontSize: 14,
              fontColor: AppColors.white,
            ),
            headerStyle: DateRangePickerHeaderStyle(
              textStyle: AppFontStyle.fontStyleW600(
                fontSize: 14,
                fontColor: AppColors.primaryAppColor1,
              ),
            ),
            rangeTextStyle: AppFontStyle.fontStyleW600(
              fontSize: 14,
              fontColor: AppColors.primaryAppColor1,
            ),
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: AppFontStyle.fontStyleW500(
                fontSize: 14,
                fontColor: AppColors.description,
              ),
            ),
            initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(
                const Duration(days: 0),
              ),
              DateTime.now().add(
                const Duration(days: 5),
              ),
            ),
          ),
        );
      },
    );
  }
}
