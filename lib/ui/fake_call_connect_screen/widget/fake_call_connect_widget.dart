import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/fake_call_connect_screen/controller/fake_call_connect_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:lottie/lottie.dart';

/// =================== Call Connect View =================== ///
class FakeCallConnectView extends StatelessWidget {
  const FakeCallConnectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<FakeCallConnectController>(
        builder: (logic) {
          return Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: CachedNetworkImage(
                    imageUrl: logic.agencyImage ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                    },
                  ),
                ),
                Container(
                  height: Get.height,
                  width: Get.width,
                  color: AppColors.white.withOpacity(0.8),
                ),
                Center(
                  child: Column(
                    children: [
                      const Spacer(),
                      Stack(
                        children: [
                          Image.asset(AppAsset.icCircle, height: 235),
                          Positioned(
                            right: 40,
                            top: 35,
                            child: Container(
                              height: 160,
                              width: 160,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                imageUrl: logic.agencyImage ?? "",
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                                },
                                errorWidget: (context, url, error) {
                                  return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            EnumLocale.txtConnecting.name.tr,
                            style: AppFontStyle.fontStyleW700(
                              fontSize: 20,
                              fontColor: AppColors.categoryText,
                            ),
                          ).paddingOnly(top: Get.height * 0.03),
                          Lottie.asset(AppAsset.loadingLottie, height: 20).paddingOnly(top: Get.height * 0.05),
                        ],
                      ),
                      Text(
                        logic.agencyName ?? "Filer",
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 22,
                          fontColor: AppColors.appButton,
                        ),
                      ).paddingOnly(bottom: Get.height * 0.25),
                      GestureDetector(
                        onTap: () {
                          logic.timer?.cancel();
                          Get.back();
                        },
                        child: Image.asset(AppAsset.icCallCut, height: 70).paddingOnly(bottom: Get.height * 0.05),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
