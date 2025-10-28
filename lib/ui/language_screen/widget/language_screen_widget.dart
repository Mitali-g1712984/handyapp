import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/localization/localizations_delegate.dart';
import 'package:handy/ui/language_screen/controller/language_screen_controller.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class LanguageAppBarView extends StatelessWidget {
  const LanguageAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtLanguage.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Language List =================== ///
class LanguageListView extends StatelessWidget {
  const LanguageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageScreenController>(
      id: Constant.idChangeLanguage,
      builder: (logic) {
        return ListView.builder(
          itemCount: Constant.countryList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return InkWell(
              overlayColor: WidgetStatePropertyAll(AppColors.transparent),
              onTap: () {
                logic.onChangeLanguage(languages[index], index);
                logic.onLanguageSave();
              },
              child: Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider, width: 1),
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Image.asset(Constant.countryList[index]["image"], height: 30).paddingOnly(right: 10),
                    Text(
                      Constant.countryList[index]["country"],
                      style: AppFontStyle.fontStyleW700(
                        fontSize: 16,
                        fontColor: AppColors.appButton,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: logic.checkedValue == index ? AppColors.primaryAppColor1 : AppColors.border,
                          width: 1.2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(1.5),
                      child: logic.checkedValue == index
                          ? Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.primaryAppColor1,
                                shape: BoxShape.circle,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 10),
            );
          },
        ).paddingAll(10);
      },
    );
  }
}
