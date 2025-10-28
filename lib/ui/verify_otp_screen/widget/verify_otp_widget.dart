import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/ui/verify_otp_screen/controller/verify_otp_controller.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:pinput/pinput.dart';

/// =================== Complete Registration App Bar =================== ///
class VerifyOtpAppBarView extends StatelessWidget {
  const VerifyOtpAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtVerification.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Description =================== ///
class VerifyOtpDescriptionView extends StatelessWidget {
  const VerifyOtpDescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.desPleaseFillDetail.name.tr,
      textAlign: TextAlign.center,
      style: AppFontStyle.fontStyleW400(
        fontSize: 14,
        fontColor: AppColors.registrationDes,
      ),
    ).paddingOnly(bottom: 20);
  }
}

/// =================== Complete Registration Des =================== ///
class VerifyOtpDesEmailView extends StatelessWidget {
  const VerifyOtpDesEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOtpController>(
      builder: (logic) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              EnumLocale.txtOTPSent.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.fontStyleW400(
                fontSize: 16,
                fontColor: AppColors.registrationDes,
              ),
            ).paddingOnly(right: 8),
            Text(
              "${logic.dialCode} ${logic.mobileNumber ?? ""}",
              textAlign: TextAlign.center,
              style: AppFontStyle.fontStyleW600(
                fontSize: 17.5,
                fontColor: AppColors.mainTitleText,
              ),
            )
          ],
        );
      },
    );
  }
}

/// =================== Complete Registration OTP =================== ///
class VerifyOtpView extends StatelessWidget {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOtpController>(
      builder: (logic) {
        return Center(
          child: Pinput(
            length: 4,
            defaultPinTheme: PinTheme(
              width: 56,
              height: 56,
              textStyle: AppFontStyle.fontStyleW700(
                fontSize: 20,
                fontColor: AppColors.mainTitleText,
              ),
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            pinAnimationType: PinAnimationType.fade,
            controller: logic.otpController,
            focusedPinTheme: PinTheme(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.mainTitleText,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ).paddingOnly(top: 17);
      },
    );
  }
}

/// =================== Complete Registration Resend OTP =================== ///
class VerifyOtpResendOTPView extends StatelessWidget {
  const VerifyOtpResendOTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOtpController>(builder: (logic) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            overlayColor: WidgetStatePropertyAll(AppColors.transparent),
            child: Text(
              EnumLocale.txtChangeNumber.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.fontStyleW700(
                fontSize: 14,
                fontColor: AppColors.redBox,
                textDecoration: TextDecoration.underline,
                decorationColor: AppColors.redBox,
              ),
            ).paddingOnly(top: 12),
          ),
          InkWell(
            onTap: () {
              log("Constant.storage.read :: ${Constant.storage.read("isResendOtp")}");

              if (Constant.storage.read("isResendOtp") == true) {
                logic.timer = Timer(const Duration(seconds: 30), () {
                  Constant.storage.write("isResendOtp", false);
                });
              } else {
                logic.onResendOtpClick(context);
              }
            },
            overlayColor: WidgetStatePropertyAll(AppColors.transparent),
            child: Text(
              EnumLocale.txtResendOTP.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.fontStyleW700(
                fontSize: 14,
                fontColor: AppColors.mainTitleText,
                textDecoration: TextDecoration.underline,
                decorationColor: AppColors.mainTitleText,
              ),
            ).paddingOnly(top: 12),
          ),
        ],
      );
    });
  }
}

/// =================== Complete Registration Button =================== ///
class VerifyOtpButtonView extends StatelessWidget {
  const VerifyOtpButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOtpController>(
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
