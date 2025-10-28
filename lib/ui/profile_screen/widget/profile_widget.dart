import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/dialog/delete_account_dialog.dart';
import 'package:handy/custom/dialog/log_out_dialog.dart';
import 'package:handy/custom/profile/profile_custom_title.dart';
import 'package:handy/custom/profile/profile_menu.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';

/// =================== App Bar =================== ///
class ProfileAppBarView extends StatelessWidget {
  const ProfileAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyProfile.name.tr,
      showLeadingIcon: false,
    );
  }
}

/// =================== Information =================== ///
class ProfileInfoView extends StatelessWidget {
  const ProfileInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileScreenController>(
      builder: (logic) {
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryAppColor1, width: 2),
                  ),
                  padding: const EdgeInsets.all(1.4),
                  child: Container(
                    height: 108,
                    width: 108,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${Constant.storage.read("customerImage")}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icPlaceholderImage).paddingAll(10);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icPlaceholderImage).paddingAll(10);
                      },
                    ),
                  ),
                ).paddingOnly(top: 15),
                Positioned(
                  top: 90,
                  left: 80,
                  child: InkWell(
                    overlayColor: WidgetStatePropertyAll(AppColors.transparent),
                    onTap: () {
                      logic.onClickEditProfile();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryAppColor1,
                        border: Border.all(color: Colors.white, width: 1.2),
                      ),
                      padding: const EdgeInsets.all(5.5),
                      child: Image.asset(
                        AppAsset.icEditProfile,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  Constant.storage.read("customerName"),
                  style: AppFontStyle.fontStyleW900(
                    fontSize: 18,
                    fontColor: AppColors.appButton,
                  ),
                ),
                Text(
                  Constant.storage.read("customerEmail"),
                  style: AppFontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.categoryText,
                  ),
                ),
                Divider(height: 0.4, color: AppColors.profileDivider).paddingOnly(top: 12, bottom: 12),
              ],
            ).paddingOnly(top: 15)
          ],
        );
      },
    );
  }
}

/// =================== General =================== ///
class ProfileGeneralView extends StatelessWidget {
  const ProfileGeneralView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileCustomTitle(
      title: EnumLocale.txtGeneral.name.tr,
      widget: Column(
        children: [
          ProfileMenu(
            image: AppAsset.icWalletOutline,
            text: EnumLocale.txtMyWallet.name.tr,
            isArrow: true,
            top: 0,
            bottom: 12,
            onTap: () {
              Get.toNamed(AppRoutes.myWallet);
            },
          ),
          Divider(height: 1.5, color: AppColors.profileDivider),
          ProfileMenu(
            image: AppAsset.icSaved,
            text: "Saved Agency",
            isArrow: true,
            top: 12,
            bottom: 12,
            onTap: () {
              Get.toNamed(
                AppRoutes.savedAgency,
                arguments: [
                  false,
                ],
              );
            },
          ),
          Divider(height: 1.5, color: AppColors.profileDivider),
          ProfileMenu(
            image: AppAsset.icAppointmentOutline,
            text: "My Booked Appointment",
            isArrow: true,
            top: 12,
            bottom: 0,
            iconColor: AppColors.primaryAppColor1,
            onTap: () {
              Get.toNamed(AppRoutes.myAppointment);
            },
          ),
        ],
      ),
    ).paddingOnly(bottom: 20);
  }
}

/// =================== Account =================== ///
class ProfileAccountView extends StatelessWidget {
  const ProfileAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileCustomTitle(
      title: EnumLocale.txtAccount.name.tr,
      widget: Column(
        children: [
          GetBuilder<ProfileScreenController>(
            id: Constant.idSwitchOn,
            builder: (logic) {
              return ProfileMenu(
                image: AppAsset.icNotificationOutline,
                text: EnumLocale.txtPushNotification.name.tr,
                isArrow: false,
                top: 0,
                bottom: 12,
                leading: SizedBox(
                  height: 30,
                  child: Switch(
                    value: logic.isSwitchOn,
                    activeColor: AppColors.green,
                    activeTrackColor: AppColors.categoryCircle,
                    inactiveThumbColor: AppColors.redBox,
                    inactiveTrackColor: AppColors.categoryCircle,
                    trackOutlineColor: WidgetStatePropertyAll(AppColors.switchBorder),
                    trackColor: WidgetStatePropertyAll(AppColors.switchBox),
                    onChanged: (value) {
                      logic.onSwitch(value);
                    },
                  ),
                ),
              );
            },
          ),
          Divider(height: 1.5, color: AppColors.profileDivider),
          ProfileMenu(
            image: AppAsset.icLanguage,
            text: EnumLocale.txtLanguage.name.tr,
            isArrow: true,
            top: 12,
            bottom: 12,
            onTap: () {
              Get.toNamed(AppRoutes.language);
            },
          ),
          Divider(height: 1.5, color: AppColors.profileDivider),
          GetBuilder<ProfileScreenController>(
            builder: (logic) {
              return ProfileMenu(
                image: AppAsset.icRate,
                text: EnumLocale.txtRateUs.name.tr,
                isArrow: true,
                top: 12,
                bottom: 12,
                onTap: () async {
                  logic.rateMyApp.reset();

                  logic.rateMyApp.init().then(
                    (_) {
                      logic.rateMyApp.showRateDialog(
                        context,
                        title: EnumLocale.txtRateThisApp.name.tr,
                        message: EnumLocale.desRateUs.name.tr,
                        rateButton: EnumLocale.txtRATE.name.tr,
                        noButton: EnumLocale.txtNoTHANKS.name.tr,
                        laterButton: EnumLocale.txtMayBeLater.name.tr,
                        listener: (button) {
                          switch (button) {
                            case RateMyAppDialogButton.rate:
                              log('Clicked on Rate');
                              break;
                            case RateMyAppDialogButton.later:
                              log('Clicked on Later');
                              break;
                            case RateMyAppDialogButton.no:
                              log('Clicked on No');
                              break;
                          }
                          return true;
                        },
                        dialogStyle: DialogStyle(
                          messageStyle: AppFontStyle.fontStyleW500(fontSize: 15, fontColor: AppColors.appButton),
                          titleStyle: AppFontStyle.fontStyleW600(fontSize: 20, fontColor: AppColors.appButton),
                          titleAlign: TextAlign.center,
                          dialogShape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onDismissed: () => logic.rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
                      );
                    },
                  );
                },
              );
            },
          ),
          Divider(height: 1.5, color: AppColors.profileDivider),
          ProfileMenu(
            image: AppAsset.icShare,
            text: EnumLocale.txtShareApp.name.tr,
            isArrow: true,
            top: 12,
            bottom: 0,
            onTap: () {
              if (Platform.isAndroid) {
                Share.share('http://play.google.com/store/apps/details?id=com.incodes.homeserviceuser');
              } else {}
            },
          ),
        ],
      ),
    ).paddingOnly(bottom: 20);
  }
}

/// =================== About =================== ///
class ProfileAboutView extends StatelessWidget {
  const ProfileAboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileCustomTitle(
      title: EnumLocale.txtAbout.name.tr,
      widget: Column(
        children: [
          ProfileMenu(
            image: AppAsset.icTerms,
            text: EnumLocale.txtTermsOfUse.name.tr,
            isArrow: true,
            top: 0,
            bottom: 12,
            onTap: () {
              Utils.launchURL(termsCondition ?? "");
            },
          ),
          Divider(height: 1.5, color: AppColors.profileDivider),
          ProfileMenu(
            image: AppAsset.icPolicy,
            text: EnumLocale.txtPrivacyPolicy.name.tr,
            isArrow: true,
            top: 12,
            bottom: 12,
            onTap: () {
              Utils.launchURL(privacyPolicy ?? "");
            },
          ),
          Divider(height: 1.5, color: AppColors.profileDivider),
          ProfileMenu(
            image: AppAsset.icHelp,
            text: EnumLocale.txtHelpFAQ.name.tr,
            isArrow: true,
            top: 12,
            bottom: 12,
            onTap: () {
              Get.toNamed(AppRoutes.helpDesk);
            },
          ),
          Divider(height: 1.5, color: AppColors.profileDivider),
          ProfileMenu(
            image: AppAsset.icLogOut,
            text: EnumLocale.txtLogOut.name.tr,
            isArrow: true,
            top: 12,
            bottom: 12,
            onTap: () {
              Get.dialog(
                barrierColor: AppColors.black.withOpacity(0.8),
                Dialog(
                  backgroundColor: AppColors.transparent,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  child: const LogOutDialog(),
                ),
              );
            },
          ),
          Divider(height: 1.5, color: AppColors.profileDivider),
          ProfileMenu(
            onTap: () {
              Get.dialog(
                barrierColor: AppColors.black.withOpacity(0.8),
                GetBuilder<ProfileScreenController>(
                  id: Constant.idDeleteCustomerProfile,
                  builder: (logic) {
                    return ProgressDialog(
                      inAsyncCall: logic.isLoading,
                      child: Dialog(
                        backgroundColor: AppColors.transparent,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        elevation: 0,
                        child: const DeleteAccountDialog(),
                      ),
                    );
                  },
                ),
              );
            },
            image: AppAsset.icDeleteAccount,
            text: EnumLocale.txtDeleteAccount.name.tr,
            isArrow: false,
            top: 12,
            bottom: 0,
            iconColor: AppColors.redBox,
            textColor: AppColors.redBox,
          ),
        ],
      ),
    );
  }
}
