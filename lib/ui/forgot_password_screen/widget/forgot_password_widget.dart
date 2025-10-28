import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/text_field/custom_text_field.dart';
import 'package:handy/custom/title/custom_title.dart';
import 'package:handy/ui/forgot_password_screen/controller/forgot_password_controller.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';

/// =================== App Bar =================== ///
class ForgotPasswordAppBarView extends StatelessWidget {
  const ForgotPasswordAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtForgotPassword.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Description =================== ///
class ForgotPasswordDesView extends StatelessWidget {
  const ForgotPasswordDesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.desPleaseFillDetail.name.tr,
      textAlign: TextAlign.center,
      style: AppFontStyle.fontStyleW400(
        fontSize: 15,
        fontColor: AppColors.registrationDes,
      ),
    ).paddingOnly(bottom: 20);
  }
}

/// =================== Email =================== ///
class ForgotPasswordEmailView extends StatelessWidget {
  const ForgotPasswordEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: CustomTitle(
            title: EnumLocale.txtEnterEmail.name.tr,
            method: CustomTextField(
              controller: logic.emailController,
              filled: true,
              fillColor: AppColors.divider,
              cursorColor: AppColors.mainTitleText,
              fontColor: AppColors.mainTitleText,
              fontSize: 16,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return EnumLocale.desEnterEmail.name.tr;
                } else if (!logic.isEmailValid(value)) {
                  return EnumLocale.desEnterValidEmailAddress.name.tr;
                }

                return null;
              },
            ),
          ),
        );
      },
    );
  }
}

/// =================== Bottom View =================== ///
class ForgotPasswordBottomView extends StatelessWidget {
  const ForgotPasswordBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onVerifyClick(context);
          },
          text: EnumLocale.txtContinue.name.tr,
          textStyle: AppFontStyle.fontStyleW800(
            fontSize: 17,
            fontColor: AppColors.primaryAppColor1,
          ),
        ).paddingAll(15);
      }
    );
  }
}
