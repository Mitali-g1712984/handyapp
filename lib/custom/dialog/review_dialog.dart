import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/text_field/custom_text_field.dart';
import 'package:handy/ui/appointment_screen/controller/appointment_screen_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';

class ReviewDialog extends StatelessWidget {
  final String customerId;
  final String agencyId;
  final String appointmentId;
  final String serviceId;
  final String providerId;

  const ReviewDialog({
    super.key,
    required this.customerId,
    required this.agencyId,
    required this.appointmentId,
    required this.serviceId,
    required this.providerId,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: Get.height * 0.55,
        child: Material(
          shape: const SquircleBorder(
            radius: BorderRadius.all(
              Radius.circular(115),
            ),
          ),
          color: AppColors.white,
          child: Column(
            children: [
              Text(
                EnumLocale.txtGiveReview.name.tr,
                style: AppFontStyle.fontStyleW700(
                  fontSize: 15,
                  fontColor: AppColors.title,
                ),
              ).paddingOnly(top: 8),
              Text(
                EnumLocale.desEnterGiveReview.name.tr,
                textAlign: TextAlign.center,
                style: AppFontStyle.fontStyleW400(
                  fontSize: 10,
                  fontColor: AppColors.degreeText,
                ),
              ).paddingOnly(top: 8),
              GetBuilder<AppointmentScreenController>(
                id: Constant.idSelectStar,
                builder: (logic) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            logic.onSelectedStar(index);
                          },
                          child: Image.asset(
                            index <= logic.selectedStarIndex ? AppAsset.icStarFilled : AppAsset.icStarOutline,
                            height: 30,
                            width: 30,
                          ).paddingOnly(left: 8, right: 8),
                        );
                      },
                    ),
                  );
                },
              ),
              GetBuilder<AppointmentScreenController>(
                builder: (logic) {
                  return CustomTextField(
                    controller: logic.reviewController,
                    filled: true,
                    fillColor: AppColors.divider,
                    maxLines: 5,
                    hintText: EnumLocale.txtEnterDetails.name.tr,
                    hintTextSize: 13,
                    hintTextColor: AppColors.appText,
                    fontColor: AppColors.appButton,
                  );
                },
              ).paddingOnly(bottom: 20),
              GetBuilder<AppointmentScreenController>(builder: (logic) {
                return PrimaryAppButton(
                  onTap: () {
                    logic.onSubmitReview(
                        customerId: customerId,
                        agencyId: agencyId,
                        appointmentId: appointmentId,
                        serviceId: serviceId,
                        providerId: providerId,
                        context: context);
                  },
                  height: 40,
                  borderRadius: 8,
                  text: EnumLocale.txtSubmit.name.tr,
                  textStyle: AppFontStyle.fontStyleW800(
                    fontSize: 17,
                    fontColor: AppColors.white,
                  ),
                ).paddingOnly(top: 20, bottom: 15);
              }),
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
