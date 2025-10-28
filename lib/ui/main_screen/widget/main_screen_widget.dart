import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/main_screen/controller/main_screen_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== Description =================== ///
class MainDescriptionView extends StatelessWidget {
  const MainDescriptionView({super.key});

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
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            color: AppColors.white,
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
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
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.registration);
                },
                child: PrimaryAppButton(
                  height: Get.height * 0.062,
                  width: Get.width,
                  text: EnumLocale.txtRegister.name.tr,
                  textStyle: AppFontStyle.fontStyleW800(
                    fontSize: 17,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                  color: AppColors.appButton,
                ).paddingOnly(top: 30),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColors.grey.withOpacity(0.15),
                    ),
                  ),
                  Text(
                    EnumLocale.txtOR.name.tr,
                    textAlign: TextAlign.center,
                    style: AppFontStyle.fontStyleW500(
                      fontSize: 13,
                      fontColor: AppColors.loginDes,
                    ),
                  ).paddingOnly(left: 10, right: 10),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColors.grey.withOpacity(0.15),
                    ),
                  )
                ],
              ).paddingOnly(top: 18, bottom: 18),
              GetBuilder<MainScreenController>(
                  id: Constant.idLoginOrSignUp,
                  builder: (logic) {
                    return InkWell(
                      onTap: () {
                        logic.signOut();

                        logic.signInWithGoogle();
                      },
                      child: Container(
                        height: Get.height * 0.062,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColors.dividerLine,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(AppAsset.icGoogle).paddingAll(5),
                            ).paddingOnly(left: 7),
                            Text(
                              EnumLocale.txtLogInGoogle.name.tr,
                              textAlign: TextAlign.center,
                              style: AppFontStyle.fontStyleW700(
                                fontSize: 15,
                                fontColor: AppColors.mainTitleText,
                              ),
                            ),
                            Image.asset(AppAsset.icArrowLeft, height: 28).paddingOnly(right: 10)
                          ],
                        ),
                      ),
                    );
                  }),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.mobileNumber);
                },
                overlayColor: const WidgetStatePropertyAll(WidgetStateColor.transparent),
                child: Container(
                  height: Get.height * 0.062,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.dividerLine,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(AppAsset.icMobile).paddingAll(5),
                      ).paddingOnly(left: 7),
                      Text(
                        EnumLocale.txtLogInMobile.name.tr,
                        textAlign: TextAlign.center,
                        style: AppFontStyle.fontStyleW700(
                          fontSize: 15,
                          fontColor: AppColors.mainTitleText,
                        ),
                      ),
                      Image.asset(AppAsset.icArrowLeft, height: 28).paddingOnly(right: 10)
                    ],
                  ),
                ).paddingOnly(top: 10, bottom: 20),
              ),
              InkWell(
                overlayColor: WidgetStatePropertyAll(AppColors.transparent),
                onTap: () {
                  Get.toNamed(AppRoutes.login);
                },
                child: RichText(
                  text: TextSpan(
                    text: EnumLocale.desAlreadyAccount.name.tr,
                    style: AppFontStyle.fontStyleW500(
                      fontSize: 14,
                      fontColor: AppColors.accountLogin,
                    ),
                    children: [
                      TextSpan(
                        text: '  ${EnumLocale.txtLogIn.name.tr}',
                        style: AppFontStyle.fontStyleW800(
                          fontSize: 14,
                          fontColor: AppColors.mainTitleText,
                        ),
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 5),
              ),
            ],
          ),
        )
      ],
    );
  }
}
