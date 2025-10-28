import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/text_field/custom_text_field.dart';
import 'package:handy/custom/title/custom_title.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/login_screen/controller/login_screen_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== Information =================== ///
class LoginAddInfoView extends StatelessWidget {
  const LoginAddInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Image.asset(AppAsset.icSplash).paddingAll(30),
        ),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: const Column(
            children: [
              LoginDesInfoView(),
              LoginInfoView(),
              LoginForgotPasswordView(),
              LoginButtonView(),
            ],
          ),
        ),
      ],
    );
  }
}

/// =================== Description =================== ///
class LoginDesInfoView extends StatelessWidget {
  const LoginDesInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          EnumLocale.desMultiVendorApp.name.tr,
          textAlign: TextAlign.center,
          style: AppFontStyle.fontStyleW900(
            fontSize: 22,
            fontColor: AppColors.mainTitleText,
          ),
        ).paddingOnly(top: 10, left: 5, right: 5),
        Text(
          EnumLocale.desHomeService.name.tr,
          textAlign: TextAlign.center,
          style: AppFontStyle.fontStyleW500(
            fontSize: 13,
            fontColor: AppColors.loginDes,
          ),
        ).paddingOnly(top: 10, left: 20, right: 20),
      ],
    );
  }
}

/// =================== Add Information(TextFormField) =================== ///
class LoginInfoView extends StatelessWidget {
  const LoginInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: Column(
            children: [
              CustomTitle(
                title: EnumLocale.txtEmail.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.emailController,
                  fillColor: AppColors.divider,
                  cursorColor: AppColors.appButton,
                  fontColor: AppColors.appButton,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterEmail.name.tr;
                    } else if (!logic.isEmailValid(value)) {
                      return EnumLocale.desEnterValidEmailAddress.name.tr;
                    }

                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20, top: 10),
              CustomTitle(
                title: EnumLocale.txtPassword.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.passwordController,
                  fillColor: AppColors.divider,
                  cursorColor: AppColors.appButton,
                  fontColor: AppColors.appButton,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  obscureText: logic.isObscure,
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
              ).paddingOnly(bottom: 10),
            ],
          ).paddingOnly(top: 10),
        );
      },
    );
  }
}

/// =================== Forgot Password =================== ///
class LoginForgotPasswordView extends StatelessWidget {
  const LoginForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.forgotPassword);
        },
        child: Text(
          EnumLocale.txtAskForgetPassword.name.tr,
          style: AppFontStyle.fontStyleW700(
            fontSize: 14,
            fontColor: AppColors.tabUnselectText,
            decorationColor: AppColors.tabUnselectText,
            textDecoration: TextDecoration.underline,
          ),
        ).paddingOnly(right: 5),
      ),
    );
  }
}

/// =================== Button =================== ///
class LoginButtonView extends StatelessWidget {
  const LoginButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenController>(
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onLogInClick(context);
          },
          text: EnumLocale.txtLogIn.name.tr,
          textStyle: AppFontStyle.fontStyleW800(
            fontSize: 17,
            fontColor: AppColors.primaryAppColor1,
          ),
        ).paddingOnly(top: 20);
      },
    );
  }
}
