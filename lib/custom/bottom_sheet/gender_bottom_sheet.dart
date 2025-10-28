import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/ui/edit_profile_screen/controller/edit_profile_controller.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';

class GenderBottomSheet extends StatelessWidget {
  const GenderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    List editProfileGender = [(EnumLocale.txtFemale.name.tr), (EnumLocale.txtMale.name.tr)];

    return Container(
      height: 200,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 6,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.viewMore,
              ),
            ),
          ).paddingOnly(top: 8, bottom: 23),
          SizedBox(
            height: 50,
            child: GetBuilder<EditProfileController>(
              id: Constant.idRegGenderSelect,
              builder: (logic) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 4,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: editProfileGender.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        logic.onGenderSelect(index);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 13),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: logic.genderSelect == index ? AppColors.primaryAppColor1 : AppColors.border,
                              width: 0.4,
                            ),
                            color: logic.genderSelect == index ? AppColors.primaryAppColor1 : AppColors.transparent),
                        child: Center(
                          child: Text(
                            editProfileGender[index],
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 16,
                              fontColor: logic.genderSelect == index ? AppColors.white : AppColors.tabUnselectText,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ).paddingOnly(left: 30, right: 30),
          const Spacer(),
          Center(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: PrimaryAppButton(
                height: 52,
                width: Get.width * 0.50,
                text: EnumLocale.txtSelectGender.name.tr,
                textStyle: AppFontStyle.fontStyleW800(
                  fontSize: 15,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ).paddingOnly(bottom: 25),
            ),
          )
        ],
      ),
    );
  }
}
