import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/socket/socket_constants.dart';
import 'package:handy/socket/socket_manager.dart';
import 'package:handy/ui/call_receive_screen/controller/call_receive_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/font_style.dart';
import 'package:lottie/lottie.dart';

class CallReceiveView extends StatelessWidget {
  const CallReceiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAsset.imChatBg),
            fit: BoxFit.cover,
          ),
        ),
        child: GetBuilder<CallReceiveController>(
          builder: (logic) {
            return Column(
              children: [
                Text(
                  "InComing Call",
                  style: AppFontStyle.fontStyleW700(
                    fontSize: 22,
                    fontColor: AppColors.appButton,
                  ),
                ).paddingOnly(top: Get.height * 0.12),
                Text(
                  logic.callerName ?? "",
                  style: AppFontStyle.fontStyleW700(
                    fontSize: 17,
                    fontColor: AppColors.appText,
                  ),
                ).paddingOnly(top: 10),
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
                          imageUrl: "${ApiConstant.BASE_URL}${logic.callerImage}",
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
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Map<String, dynamic> audioCallResponseMap = {
                          'role': "customer",
                          'callerId': logic.receiverId,
                          'receiverId': logic.callerId,
                          'callerImage': logic.callerImage,
                          'callerName': logic.callerName,
                          'receiverName': logic.receiverName,
                          'receiverImage': logic.receiverImage,
                          'callId': logic.callId,
                          'isAccept': false,
                          'receiverRole': logic.receiverRole,
                        };
                        SocketManager.emit(SocketConstants.audioCallResponse, audioCallResponseMap);
                      },
                      child: Lottie.asset(AppAsset.callCut, height: 100),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Map<String, dynamic> audioCallResponseMap = {
                          'role': "customer",
                          'callerId': logic.receiverId,
                          'receiverId': logic.callerId,
                          'callerImage': logic.callerImage,
                          'callerName': logic.callerName,
                          'receiverName': logic.receiverName,
                          'receiverImage': logic.receiverImage,
                          'callId': logic.callId,
                          'isAccept': true,
                          'receiverRole': logic.receiverRole,
                        };
                        SocketManager.emit(SocketConstants.audioCallResponse, audioCallResponseMap);
                      },
                      child: Lottie.asset(AppAsset.callReceive, height: 130),
                    ),
                  ],
                ).paddingOnly(bottom: Get.height * 0.05, left: Get.width * 0.1, right: Get.width * 0.1)
              ],
            );
          },
        ),
      ),
    );
  }
}
