import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/bottom_sheet/gender_bottom_sheet.dart';
import 'package:handy/custom/text_field/custom_text_field.dart';
import 'package:handy/custom/title/custom_title.dart';
import 'package:handy/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:handy/ui/edit_profile_screen/controller/edit_profile_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

/// =================== App Bar =================== ///
class EditProfileAppBarView extends StatelessWidget {
  const EditProfileAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtEditProfile.name.tr,
      showLeadingIcon: Constant.storage.read("isMobileLogin") == true ? false : true,
    );
  }
}

/// =================== Add Image =================== ///
class EditProfileImageView extends StatelessWidget {
  const EditProfileImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      id: Constant.idEditImage,
      builder: (logic) {
        return Stack(
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
                child: logic.selectImageFile?.path == null
                    ? CachedNetworkImage(
                        imageUrl: "${ApiConstant.BASE_URL}${Constant.storage.read("customerImage")}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                        },
                        errorWidget: (context, url, error) {
                          return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                        },
                      )
                    : Image.file(
                        File(logic.selectImageFile?.path ?? ""),
                        fit: BoxFit.cover,
                      ),
              ),
            ).paddingOnly(top: 15),
            Positioned(
              top: 90,
              left: 80,
              child: InkWell(
                overlayColor: WidgetStatePropertyAll(AppColors.transparent),
                onTap: () {
                  logic.onPickImage();
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
                    AppAsset.icCamera,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

/// =================== Edit Info(TextField) =================== ///
class EditProfileAddDataView extends StatelessWidget {
  const EditProfileAddDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
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
                  cursorColor: AppColors.appButton,
                  fontColor: AppColors.appButton,
                  fontSize: 15,
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
                  cursorColor: AppColors.appButton,
                  fontColor: AppColors.appButton,
                  fontSize: 15,
                  readOnly: Constant.storage.read("isGoogleLogin") == true ? true : false,
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
              Constant.storage.read("isGoogleLogin") == true
                  ? const SizedBox()
                  : CustomTitle(
                      title: EnumLocale.txtMobileNumber.name.tr,
                      method: const EditProfilePhoneNumberView(),
                    ).paddingOnly(bottom: 20),
              CustomTitle(
                title: EnumLocale.txtSelectCountry.name.tr,
                method: const EditProfileCountryView(),
              ).paddingOnly(bottom: 20),
              CustomTitle(
                title: EnumLocale.txtSelectGender.name.tr,
                method: const EditProfileGenderView(),
              ).paddingOnly(bottom: 20),
            ],
          ).paddingOnly(left: 13, right: 13),
        );
      },
    );
  }
}

/// =================== Mobile Number =================== ///
class EditProfilePhoneNumberView extends StatelessWidget {
  const EditProfilePhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (logic) {
        return IntlPhoneField(
          flagsButtonPadding: const EdgeInsets.all(8),
          flagsButtonMargin: const EdgeInsets.only(right: 13),
          dropdownIconPosition: IconPosition.trailing,
          controller: logic.numberController,
          obscureText: false,
          readOnly: Constant.storage.read("isMobileLogin") == true ? true : false,
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
        );
      },
    );
  }
}

/// =================== Country =================== ///
class EditProfileCountryView extends StatelessWidget {
  const EditProfileCountryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      id: Constant.idSelectCountry,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              favorite: <String>['IN'],
              showPhoneCode: false,
              onSelect: (Country country) {
                logic.onCountryChange(country.name);
              },
              showSearch: false,
              countryListTheme: CountryListThemeData(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                bottomSheetHeight: Get.height * 0.55,
                flagSize: 30,
                textStyle: AppFontStyle.fontStyleW700(
                  fontSize: 13,
                  fontColor: AppColors.appButton,
                ),
              ),
            );
          },
          child: Container(
            height: Get.height * 0.06,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  logic.countryName ?? "India",
                  style: AppFontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.appButton,
                  ),
                ),
                Image.asset(
                  AppAsset.icArrowDown,
                  height: 23,
                  width: 23,
                  color: AppColors.appButton,
                ),
              ],
            ).paddingOnly(left: 15, right: 15),
          ),
        );
      },
    );
  }
}

/// =================== Gender =================== ///
class EditProfileGenderView extends StatelessWidget {
  const EditProfileGenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      id: Constant.idRegGenderSelect,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return const GenderBottomSheet();
              },
            );
          },
          child: Container(
            height: Get.height * 0.06,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  logic.genderName ?? "Female",
                  style: AppFontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.appButton,
                  ),
                ),
                Image.asset(
                  AppAsset.icArrowDown,
                  height: 23,
                  width: 23,
                  color: AppColors.appButton,
                ),
              ],
            ).paddingOnly(left: 15, right: 15),
          ),
        );
      },
    );
  }
}

/// =================== Save Button =================== ///
class EditProfileSavedButtonView extends StatelessWidget {
  const EditProfileSavedButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      id: Constant.idEditCustomer,
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onSaveProfileClick(context);
          },
          text: EnumLocale.txtSaveProfile.name.tr,
          textStyle: AppFontStyle.fontStyleW800(
            fontSize: 17,
            fontColor: AppColors.primaryAppColor1,
          ),
        ).paddingAll(15);
      },
    );
  }
}
