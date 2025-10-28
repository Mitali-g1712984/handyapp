import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/ui/apply_coupon_screen/controller/apply_coupon_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class ApplyCouponAppBarView extends StatelessWidget {
  const ApplyCouponAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyCouponController>(
      id: Constant.idApplyCoupon,
      builder: (logic) {
        return CustomAppBar(
          title: EnumLocale.txtApplyCoupon.name.tr,
          showLeadingIcon: true,
          onTap: () {
            logic.onBackApplyCouponWithoutSelect();
            Get.back();
          },
        );
      },
    );
  }
}

/// =================== List View =================== ///
class ApplyCouponListView extends StatelessWidget {
  const ApplyCouponListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyCouponController>(
      id: Constant.idGetCoupon,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.applyCouponShimmer()
            : logic.getCouponModel?.data?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icPlaceholderNoData,
                    imageHeight: 200,
                    text: EnumLocale.noDataFoundForCoupon.name.tr,
                  ).paddingOnly(bottom: Get.height * 0.13)
                : ListView.builder(
                    itemCount: logic.getCouponModel?.data?.length ?? 0,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ApplyCouponListItemView(index: index);
                    },
                  ).paddingOnly(top: 20, bottom: 20);
      },
    );
  }
}

class ApplyCouponListItemView extends StatelessWidget {
  final int index;

  const ApplyCouponListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyCouponController>(
      id: Constant.idApplyCoupon,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onApplyCoupon(index);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  logic.applyCoupon == index ? AppAsset.imSelectCouponBox : AppAsset.imCouponBox,
                ),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width * 0.62,
                      child: Text(
                        logic.getCouponModel?.data?[index].title ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.fontStyleW800(
                          fontSize: 21,
                          fontColor: logic.applyCoupon == index ? AppColors.primaryAppColor1 : AppColors.appButton,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: logic.applyCoupon == index ? AppColors.primaryAppColor1 : AppColors.couponBox,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: '${EnumLocale.txtOfferValidity.name.tr}  ',
                          style: AppFontStyle.fontStyleW700(
                            fontSize: 13,
                            fontColor: logic.applyCoupon == index ? AppColors.appButton : AppColors.white,
                          ),
                          children: [
                            TextSpan(
                              text: logic.getCouponModel?.data?[index].expiryDate ?? "",
                              style: AppFontStyle.fontStyleW900(
                                fontSize: 13,
                                fontColor: logic.applyCoupon == index ? AppColors.appButton : AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: Get.width * 0.62,
                      child: Text(
                        logic.getCouponModel?.data?[index].description ?? "",
                        style: AppFontStyle.fontStyleW700(
                          fontSize: 12,
                          fontColor: logic.applyCoupon == index ? AppColors.white : AppColors.appButton.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: Get.width * 0.62,
                      child: Row(
                        children: [
                          Text(
                            "Max Discount: ",
                            style: AppFontStyle.fontStyleW500(
                              fontSize: 12,
                              fontColor: logic.applyCoupon == index ? AppColors.white : AppColors.appButton.withOpacity(0.5),
                            ),
                          ).paddingOnly(right: 5),
                          Text(
                            "$currency${logic.getCouponModel?.data?[index].maxDiscount.toString()}",
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 13,
                              fontColor: logic.applyCoupon == index ? AppColors.white : AppColors.appButton.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).paddingOnly(top: 13, bottom: 13, left: 28),
                Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: logic.applyCoupon == index ? AppColors.white : AppColors.appButton,
                      width: 1.3,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: logic.applyCoupon == index
                      ? Container(
                          height: 21,
                          width: 21,
                          decoration: BoxDecoration(
                            color: AppColors.primaryAppColor1,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(AppAsset.icCheck).paddingAll(5),
                        )
                      : const SizedBox.shrink(),
                ).paddingOnly(right: Get.width * 0.09)
              ],
            ),
          ).paddingOnly(bottom: 15),
        );
      },
    );
  }
}

/// =================== Bottom View =================== ///
class ApplyCouponBottomView extends StatelessWidget {
  const ApplyCouponBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyCouponController>(
      id: Constant.idApplyCoupon,
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onApplyCouponClick();
          },
          width: Get.width * 0.9,
          text: EnumLocale.txtApplyCouponCode.name.tr,
          color: logic.applyCoupon == -1 ? AppColors.divider : AppColors.appButton,
          textStyle: AppFontStyle.fontStyleW800(
            fontSize: 17,
            fontColor: logic.applyCoupon == -1 ? AppColors.greyText : AppColors.primaryAppColor1,
          ),
        ).paddingAll(12);
      },
    );
  }
}
