import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/socket/socket_constants.dart';
import 'package:handy/socket/socket_manager.dart';
import 'package:handy/ui/call_connect_screen/controller/call_connect_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:lottie/lottie.dart';

/// =================== Call Connect View =================== ///
class CallConnectView extends StatelessWidget {
  const CallConnectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<CallConnectController>(
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
                    imageUrl: "${ApiConstant.BASE_URL}${logic.receiverImage}",
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
                GetBuilder<CallConnectController>(
                  builder: (logic) {
                    return Center(
                      child: Column(
                        children: [
                          const Spacer(),
                          Stack(
                            children: [
                              Lottie.asset(AppAsset.roundWaveLottie, height: 350),
                              Positioned(
                                right: 98,
                                top: 96,
                                child: Container(
                                  height: 155,
                                  width: 155,
                                  decoration: const BoxDecoration(shape: BoxShape.circle),
                                  clipBehavior: Clip.hardEdge,
                                  child: CachedNetworkImage(
                                    imageUrl: "${ApiConstant.BASE_URL}${logic.receiverImage}",
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
                            logic.receiverName ?? "",
                            style: AppFontStyle.fontStyleW900(
                              fontSize: 22,
                              fontColor: AppColors.appButton,
                            ),
                          ).paddingOnly(bottom: Get.height * 0.18),
                          GestureDetector(
                            onTap: () {
                              Map<String, dynamic> callCancelMap = {
                                'role': 'customer',
                                'callerId': logic.callerId,
                                'receiverId': logic.receiverId,
                                'callId': logic.callId,
                                'receiverRole': logic.receiverRole,
                              };

                              SocketManager.emit(SocketConstants.callCancel, callCancelMap);
                            },
                            child: Image.asset(AppAsset.icCallCut, height: 70).paddingOnly(bottom: Get.height * 0.05),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
