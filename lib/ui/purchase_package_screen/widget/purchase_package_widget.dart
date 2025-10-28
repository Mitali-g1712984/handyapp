import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/ui/purchase_package_screen/controller/purchase_package_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';

/// =================== App Bar =================== ///
class PurchasePackageAppBarView extends StatelessWidget {
  const PurchasePackageAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Package Purchase",
      showLeadingIcon: true,
    );
  }
}

class PurchasePackageImageView extends StatelessWidget {
  const PurchasePackageImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchasePackageController>(
      builder: (logic) {
        return Container(
          height: 200,
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.greyText.withOpacity(0.2),
            borderRadius: BorderRadius.circular(18),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: "${ApiConstant.BASE_URL}${logic.matchingPackage?.image ?? " "}",
                fit: BoxFit.cover,
                width: Get.width,
                placeholder: (context, url) {
                  return Image.asset(AppAsset.icPlaceholderImage).paddingAll(20);
                },
                errorWidget: (context, url, error) {
                  return Image.asset(AppAsset.icPlaceholderImage).paddingAll(20);
                },
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primaryAppColor1,
                  ),
                  child: Text(
                    "$currency${logic.matchingPackage?.price?.toStringAsFixed(2)}",
                    style: AppFontStyle.fontStyleW700(
                      fontSize: 13,
                      fontColor: AppColors.appButton,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ).paddingAll(15);
      },
    );
  }
}

class PurchasePackageDescriptionView extends StatelessWidget {
  const PurchasePackageDescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchasePackageController>(
      builder: (logic) {
        return Text(
          "• ${logic.matchingPackage?.description ?? " "}",
          style: AppFontStyle.fontStyleW500(
            fontSize: 15,
            fontColor: AppColors.greyText,
          ),
        ).paddingOnly(left: 15, right: 15);
      },
    );
  }
}

class PurchasePackageServiceTitleView extends StatelessWidget {
  const PurchasePackageServiceTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Service included in this package",
      style: AppFontStyle.fontStyleW600(
        fontSize: 15,
        fontColor: AppColors.mainTitleText,
      ),
    ).paddingOnly(left: 15, top: 15);
  }
}

class PurchasePackageServiceListView extends StatelessWidget {
  const PurchasePackageServiceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchasePackageController>(
      id: Constant.idGetAgencyInfo,
      builder: (logic) {
        return Expanded(
          child: ListView.builder(
            itemCount: logic.matchingPackage?.service?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                height: 70,
                width: Get.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.grey.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: "${ApiConstant.BASE_URL}${logic.matchingPackage?.service?[index].image ?? ""}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                        },
                        errorWidget: (context, url, error) {
                          return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width * 0.65,
                          child: Text(
                            logic.matchingPackage?.service?[index].name ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 14,
                              fontColor: AppColors.mainTitleText,
                            ),
                          ),
                        ),
                        Text(
                          "$currency ${logic.matchingPackage?.service?[index].price?.toStringAsFixed(2) ?? ""}",
                          style: AppFontStyle.fontStyleW700(
                            fontSize: 14,
                            fontColor: AppColors.primaryAppColor1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 12);
            },
          ).paddingOnly(left: 15, right: 15, top: 15),
        );
      },
    );
  }
}

class PurchasePackageBottomView extends StatelessWidget {
  const PurchasePackageBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchasePackageController>(
      id: Constant.idGetAgencyInfo,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onBookNowClick();
          },
          child: PrimaryAppButton(
            text: "${EnumLocale.txtBookNow.name.tr} $currency ${logic.matchingPackage?.price ?? 0.0}",
            textStyle: AppFontStyle.fontStyleW900(
              fontSize: 17,
              fontColor: AppColors.primaryAppColor1,
            ),
          ).paddingOnly(left: 15, right: 15, bottom: 15),
        );
      },
    );
  }
}
