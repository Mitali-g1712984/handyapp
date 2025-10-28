import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/fake_voice_call_screen/controller/fake_voice_call_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/font_style.dart';

/// =================== Video Call View =================== ///
class FakeVoiceCallView extends StatelessWidget {
  const FakeVoiceCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FakeVoiceCallController>(
      id: Constant.idVideoCall,
      builder: (logic) {
        return SizedBox(
          height: Get.height,
          width: Get.width,
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
                    Text(
                      logic.agencyName ?? "Filer",
                      style: AppFontStyle.fontStyleW900(
                        fontSize: 22,
                        fontColor: AppColors.appButton,
                      ),
                    ).paddingOnly(top: Get.height * 0.05),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.divider,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        logic.formattedTime ?? "12:00",
                        style: AppFontStyle.fontStyleW700(
                          fontSize: 14,
                          fontColor: AppColors.tabUnselectText,
                        ),
                      ),
                    ).paddingOnly(bottom: Get.height * 0.35, top: 10),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Get.height * 0.12,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<FakeVoiceCallController>(
                        id: Constant.idMicMute,
                        builder: (logic) {
                          return GestureDetector(
                            onTap: () {
                              logic.onSpeakerOn();
                            },
                            child: Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryAppColor1),
                              child: logic.isSpeakerOn == true
                                  ? Image.asset(AppAsset.icSpeakerOff).paddingAll(15)
                                  : Image.asset(AppAsset.icSpeakerOn).paddingAll(15),
                            ),
                          );
                        },
                      ),
                      GetBuilder<FakeVoiceCallController>(
                        id: Constant.idVideoTurn,
                        builder: (logic) {
                          return GestureDetector(
                            onTap: () {
                              logic.onMicMute();
                            },
                            child: Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryAppColor1),
                              child: logic.isMicMute == true
                                  ? Image.asset(AppAsset.icMicOff).paddingAll(15)
                                  : Image.asset(AppAsset.icMic).paddingAll(15),
                            ),
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          logic.timer?.cancel();
                          Get.back();
                        },
                        child: Image.asset(AppAsset.icCallCut, height: 56),
                      ),
                    ],
                  ).paddingOnly(left: 40, right: 40),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
