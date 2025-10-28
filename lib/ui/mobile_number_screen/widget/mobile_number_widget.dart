import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/title/custom_title.dart';
import 'package:handy/ui/mobile_number_screen/controller/mobile_number_controller.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

/// =================== Complete Registration App Bar =================== ///
class MobileNumberAppBarView extends StatelessWidget {
  const MobileNumberAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMobileNumber.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Description =================== ///
class MobileNumberDescriptionView extends StatelessWidget {
  const MobileNumberDescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.desPleaseFillDetail.name.tr,
      textAlign: TextAlign.center,
      style: AppFontStyle.fontStyleW400(
        fontSize: 14,
        fontColor: AppColors.registrationDes,
      ),
    );
  }
}

/// =================== Complete Registration OTP =================== ///
class MobileNumberOTPView extends StatelessWidget {
  const MobileNumberOTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTitle(
      title: EnumLocale.txtMobileNumber.name.tr,
      method: GetBuilder<MobileNumberController>(
        builder: (logic) {
          return Form(
            key: logic.formKey,
            child: IntlPhoneField(
              flagsButtonPadding: const EdgeInsets.all(8),
              flagsButtonMargin: const EdgeInsets.only(right: 13),
              dropdownIconPosition: IconPosition.trailing,
              controller: logic.numberController,
              obscureText: false,
              validator: (value) {
                if (value == null) {
                  return EnumLocale.desEnterMobile.name.tr;
                }
                return null;
              },
              style: AppFontStyle.fontStyleW600(
                fontSize: 12,
                fontColor: AppColors.appButton,
              ),
              cursorColor: AppColors.appButton,
              dropdownTextStyle: AppFontStyle.fontStyleW700(
                fontSize: 16,
                fontColor: AppColors.white,
              ),
              pickerDialogStyle: PickerDialogStyle(
                countryCodeStyle: AppFontStyle.fontStyleW700(
                  fontSize: 13,
                  fontColor: AppColors.appButton,
                ),
                countryNameStyle: AppFontStyle.fontStyleW700(
                  fontSize: 13,
                  fontColor: AppColors.appButton,
                ),
                searchFieldCursorColor: AppColors.appButton,
                searchFieldInputDecoration: InputDecoration(
                  hintStyle: AppFontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.viewMore,
                  ),
                  hintText: EnumLocale.txtSearchCountryCode.name.tr,
                ),
              ),
              dropdownIcon: Icon(
                Icons.arrow_drop_down_outlined,
                color: AppColors.white,
              ),
              keyboardType: TextInputType.number,
              showCountryFlag: true,
              decoration: InputDecoration(
                hintStyle: AppFontStyle.fontStyleW600(
                  fontSize: 12,
                  fontColor: AppColors.appButton,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.transparent),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.transparent),
                ),
                filled: true,
                fillColor: AppColors.divider,
                errorStyle: AppFontStyle.fontStyleW500(
                  fontSize: 8,
                  fontColor: AppColors.redBox,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.redBox),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.redBox),
                ),
                counterStyle: AppFontStyle.fontStyleW500(
                  fontSize: 9,
                  fontColor: AppColors.loginDes,
                ),
              ),
              dropdownDecoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: AppColors.primaryAppColor1,
              ),
              initialCountryCode: countryCode ?? 'IN',
              onCountryChanged: (value) {
                log("message :: ${value.code}");
                countryCode = value.code;

                getDialCode();
              },
              onChanged: (phone) {
                log("Phone :: ${phone.completeNumber}");
              },
            ),
          );
        },
      ),
    ).paddingOnly(top: 20);
  }
}

/// =================== Complete Registration Button =================== ///
class MobileNumberButtonView extends StatelessWidget {
  const MobileNumberButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MobileNumberController>(
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onVerifyClick(context);
          },
          text: EnumLocale.txtVerify.name.tr,
          textStyle: AppFontStyle.fontStyleW800(
            fontSize: 17,
            fontColor: AppColors.primaryAppColor1,
          ),
        ).paddingOnly(bottom: 15);
      },
    );
  }
}
