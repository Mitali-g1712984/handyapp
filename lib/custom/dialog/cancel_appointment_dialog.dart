import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/text_field/custom_text_field.dart';
import 'package:handy/ui/appointment_screen/controller/appointment_screen_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';

class CancelAppointmentDialog extends StatelessWidget {
  final String appointmentId;

  const CancelAppointmentDialog({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 475,
        child: Material(
          shape: const SquircleBorder(
            radius: BorderRadius.all(
              Radius.circular(90),
            ),
          ),
          color: AppColors.white,
          child: Column(
            children: [
              Image.asset(
                AppAsset.icCancel,
                height: 100,
              ).paddingOnly(top: 15),
              Text(
                EnumLocale.txtAppointmentCancellation.name.tr,
                style: AppFontStyle.fontStyleW900(
                  fontSize: 22,
                  fontColor: AppColors.redBox,
                ),
              ).paddingOnly(top: 8),
              Text(
                EnumLocale.desDoCancelAppointment.name.tr,
                textAlign: TextAlign.center,
                style: AppFontStyle.fontStyleW500(
                  fontSize: 14,
                  fontColor: AppColors.categoryText,
                ),
              ).paddingOnly(top: 8, bottom: 13),
              GetBuilder<AppointmentScreenController>(
                builder: (logic) {
                  return CustomTextField(
                    controller: logic.reasonController,
                    filled: true,
                    fillColor: AppColors.divider,
                    maxLines: 4,
                    hintText: EnumLocale.txtEnterCancellationReason.name.tr,
                    hintTextSize: 13,
                    hintTextColor: AppColors.appText,
                    fontColor: AppColors.appButton,
                  );
                },
              ).paddingOnly(bottom: 15),
              const Spacer(),
              GetBuilder<AppointmentScreenController>(
                builder: (logic) {
                  return PrimaryAppButton(
                    onTap: () {
                      logic.onCancelAppointment(
                        appointmentId: appointmentId,
                        context: context,
                      );
                    },
                    height: 40,
                    borderRadius: 8,
                    color: AppColors.redBox,
                    text: EnumLocale.txtCancelAppointment.name.tr,
                    textStyle: AppFontStyle.fontStyleW800(
                      fontSize: 17,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(top: 20, bottom: 10);
                },
              ),
              PrimaryAppButton(
                onTap: () {
                  Get.back();
                },
                height: 40,
                borderRadius: 8,
                color: AppColors.divider,
                text: EnumLocale.txtClose.name.tr,
                textStyle: AppFontStyle.fontStyleW800(
                  fontSize: 17,
                  fontColor: AppColors.tabUnselectText,
                ),
              ).paddingOnly(bottom: 5)
            ],
          ).paddingAll(15),
        ),
      ),
    );
  }
}
