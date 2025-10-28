import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/text_field/custom_text_field.dart';
import 'package:handy/custom/title/custom_title.dart';
import 'package:handy/ui/set_password_screen/controller/set_password_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';

/// =================== App Bar =================== ///
class SetPasswordAppBarView extends StatelessWidget {
  const SetPasswordAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtSetPassword.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Description =================== ///
class SetPasswordDesView extends StatelessWidget {
  const SetPasswordDesView({super.key});

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

class SetPasswordReEnterPasswordView extends StatelessWidget {
  const SetPasswordReEnterPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetPasswordController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                title: EnumLocale.txtPassword.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.passwordController,
                  fillColor: AppColors.divider,
                  cursorColor: AppColors.mainTitleText,
                  fontColor: AppColors.mainTitleText,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  obscureText: logic.isObscure,
                  maxLines: 1,
                  suffixIcon: logic.isObscure
                      ? InkWell(
                          onTap: () {
                            logic.onClickObscure();
                          },
                          child: Image.asset(
                            AppAsset.icEyeUnVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        )
                      : InkWell(
                          onTap: () {
                            logic.onClickObscure();
                          },
                          child: Image.asset(
                            AppAsset.icEyeVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterPassword.name.tr;
                    } else if (value.length < 6) {
                      return EnumLocale.desPasswordCharacters.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20),
              CustomTitle(
                title: EnumLocale.txtRePassword.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.rePasswordController,
                  fillColor: AppColors.divider,
                  cursorColor: AppColors.mainTitleText,
                  fontColor: AppColors.mainTitleText,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  obscureText: logic.isObscure1,
                  maxLines: 1,
                  suffixIcon: logic.isObscure1
                      ? InkWell(
                          onTap: () {
                            logic.onClickObscure1();
                          },
                          child: Image.asset(
                            AppAsset.icEyeUnVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        )
                      : InkWell(
                          onTap: () {
                            logic.onClickObscure1();
                          },
                          child: Image.asset(
                            AppAsset.icEyeVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desReEnterPassword.name.tr;
                    } else if (value != logic.passwordController.text) {
                      return EnumLocale.desPasswordNotMatch.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20),
            ],
          ).paddingOnly(top: 15),
        );
      },
    );
  }
}

/// =================== Bottom View =================== ///
class SetPasswordBottomView extends StatelessWidget {
  const SetPasswordBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetPasswordController>(
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onConfirmButtonClick(context);
          },
          text: EnumLocale.txtConfirm.name.tr,
          textStyle: AppFontStyle.fontStyleW800(
            fontSize: 17,
            fontColor: AppColors.primaryAppColor1,
          ),
        ).paddingAll(15);
      },
    );
  }
}
