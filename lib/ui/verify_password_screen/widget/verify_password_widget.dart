import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/ui/verify_password_screen/controller/verify_password_controller.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:pinput/pinput.dart';

/// =================== Complete Registration App Bar =================== ///
class VerifyPasswordAppBarView extends StatelessWidget {
  const VerifyPasswordAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtVerification.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Description =================== ///
class VerifyPasswordDescriptionView extends StatelessWidget {
  const VerifyPasswordDescriptionView({super.key});

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
class VerifyPasswordDesEmailView extends StatelessWidget {
  const VerifyPasswordDesEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyPasswordController>(
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
              logic.email ?? "",
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
class VerifyPasswordOTPView extends StatelessWidget {
  const VerifyPasswordOTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyPasswordController>(
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
        );
      },
    ).paddingOnly(top: 22);
  }
}

/// =================== Complete Registration Resend OTP =================== ///
class VerifyPasswordResendOTPView extends StatelessWidget {
  const VerifyPasswordResendOTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyPasswordController>(
      builder: (logic) {
        return InkWell(
          onTap: () {
            logic.onClickResendOtpForLogin();
          },
          overlayColor: const WidgetStatePropertyAll(WidgetStateColor.transparent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive the code?",
                style: AppFontStyle.fontStyleW500(
                  fontSize: 14,
                  fontColor: AppColors.grey.withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                EnumLocale.txtResendOTP.name.tr,
                style: AppFontStyle.fontStyleW600(
                  fontSize: 14,
                  fontColor: AppColors.redBox,
                  textDecoration: TextDecoration.underline,
                  decorationColor: AppColors.redBox,
                ),
              ),
            ],
          ).paddingOnly(top: 17),
        );
      },
    );
  }
}

/// =================== Complete Registration Button =================== ///
class VerifyPasswordButtonView extends StatelessWidget {
  const VerifyPasswordButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyPasswordController>(
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onVerifyOtp();
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
