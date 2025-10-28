import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/text_field/custom_text_field.dart';
import 'package:handy/custom/title/custom_title.dart';
import 'package:handy/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:handy/ui/registration_screen/controller/registration_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';

/// =================== App Bar =================== ///
class RegistrationAppBarView extends StatelessWidget {
  const RegistrationAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtRegistration.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Description =================== ///
class RegistrationDesView extends StatelessWidget {
  const RegistrationDesView({super.key});

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

/// =================== Add Information(TextFormField) =================== ///
class RegistrationAddInfoView extends StatelessWidget {
  const RegistrationAddInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: Column(
            children: [
              CustomTitle(
                title: EnumLocale.txtFullName.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.nameController,
                  fillColor: AppColors.divider,
                  cursorColor: AppColors.mainTitleText,
                  fontColor: AppColors.mainTitleText,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [UpperCaseTextFormatter()],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterFullName.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20),
              CustomTitle(
                title: EnumLocale.txtEmail.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.emailController,
                  fillColor: AppColors.divider,
                  cursorColor: AppColors.mainTitleText,
                  fontColor: AppColors.mainTitleText,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
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
              ).paddingOnly(bottom: 20),
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
                  maxLines: 1,
                  obscureText: logic.isObscure1,
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
          ),
        );
      },
    );
  }
}

class RegistrationBottomView extends StatelessWidget {
  const RegistrationBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.17,
      width: Get.width,
      color: AppColors.transparent,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RegistrationTncAndPolicyView(),
          RegistrationButtonView(),
        ],
      ),
    );
  }
}

/// =================== Button =================== ///
class RegistrationButtonView extends StatelessWidget {
  const RegistrationButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onVerifyClick(context);
          },
          child: PrimaryAppButton(
            text: EnumLocale.txtVerify.name.tr,
            textStyle: AppFontStyle.fontStyleW800(
              fontSize: 17,
              fontColor: AppColors.primaryAppColor1,
            ),
          ).paddingOnly(left: 12, right: 12, bottom: 12),
        );
      },
    );
  }
}

/// =================== Terms-Condition & Policy =================== ///
class RegistrationTncAndPolicyView extends StatelessWidget {
  const RegistrationTncAndPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      id: Constant.idAcceptTerms,
      builder: (logic) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                logic.onClickCheck();
              },
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: logic.isCheck
                        ? AppColors.primaryAppColor1
                        : AppColors.grey.withOpacity(0.5),
                    width: 0.8,
                  ),
                  shape: BoxShape.circle,
                  color: logic.isCheck ? AppColors.primaryAppColor1 : Colors.white,
                ),
                child: logic.isCheck
                    ? Image.asset(
                        AppAsset.icCheck,
                        color: AppColors.white,
                      ).paddingAll(5)
                    : const SizedBox(),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                Utils.launchURL(termsCondition ?? "");
              },
              child: RichText(
                text: TextSpan(
                  text: EnumLocale.desByProceedingForward.name.tr,
                  style: AppFontStyle.fontStyleW400(
                    fontSize: 15,
                    fontColor: AppColors.accountLogin,
                  ),
                  children: [
                    TextSpan(
                      text: '\n${EnumLocale.txtPrivacyPolicy.name.tr}',
                      style: AppFontStyle.fontStyleW600(
                        fontSize: 16,
                        fontColor: AppColors.mainTitleText,
                        textDecoration: TextDecoration.underline,
                        decorationColor: AppColors.mainTitleText,
                      ),
                    ),
                    TextSpan(
                      text: ' ${EnumLocale.txtAnd.name.tr} ',
                      style: AppFontStyle.fontStyleW400(
                        fontSize: 15,
                        fontColor: AppColors.accountLogin,
                      ),
                    ),
                    TextSpan(
                      text: EnumLocale.txtTermsCondition.name.tr,
                      style: AppFontStyle.fontStyleW600(
                        fontSize: 16,
                        fontColor: AppColors.mainTitleText,
                        textDecoration: TextDecoration.underline,
                        decorationColor: AppColors.mainTitleText,
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 15, top: 20),
            ),
          ],
        ).paddingOnly(left: 15);
      },
    );
  }
}
