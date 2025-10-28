import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/custom/dialog/image_view_dialog.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/socket/socket_constants.dart';
import 'package:handy/socket/socket_manager.dart';
import 'package:handy/ui/personal_chat_screen/controller/personal_chat_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:handy/utils/shimmers.dart';
import 'package:intl/intl.dart';

/// =================== Top View =================== ///
class PersonalChatTopView extends StatelessWidget {
  const PersonalChatTopView({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: Get.height * 0.10 + statusBarHeight,
      width: Get.width,
      padding: EdgeInsets.only(top: statusBarHeight - 10),
      color: AppColors.primaryAppColor1,
      child: GetBuilder<PersonalChatController>(
        id: Constant.idGetProviderService,
        builder: (logic) {
          return Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(AppAsset.icArrowRight, height: 22, width: 22),
              ),
              Container(
                height: 45,
                width: 45,
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white,
                    width: 1,
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    imageUrl: "${ApiConstant.BASE_URL}${logic.receiverRoleImage}",
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    logic.receiverRoleName ?? "",
                    style: AppFontStyle.fontStyleW900(
                      fontSize: 17,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(bottom: 3),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(4),
                  //     color: AppColors.white,
                  //   ),
                  //   padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  //   child: Text(
                  //     "Service Name",
                  //     style: AppFontStyle.fontStyleW600(
                  //       fontSize: 10,
                  //       fontColor: AppColors.appButton,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Map<String, dynamic> audioCallInitiated = {
                    'role': "customer",
                    'callerId': Constant.storage.read("customerId"),
                    'receiverId': logic.receiverRoleId ?? "",
                    'callerName': Constant.storage.read("customerName"),
                    'receiverName': logic.receiverRoleName,
                    'receiverRole': logic.receiverRole,
                  };

                  SocketManager.emit(SocketConstants.audioCallInitiated, audioCallInitiated);
                },
                child: Image.asset(
                  AppAsset.icCall1,
                  height: 23,
                  color: AppColors.white,
                ),
              ),
            ],
          ).paddingOnly(left: 12, right: 18);
        },
      ),
    );
  }
}

/// =================== Message View =================== ///
class PersonalChatMessageView extends StatelessWidget {
  const PersonalChatMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalChatController>(
      builder: (logic) {
        return Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAsset.imChatBg),
              fit: BoxFit.cover,
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PersonalMessageBottomView(),
              PersonalChatBottomView(),
            ],
          ),
        );
      },
    );
  }
}

/// =================== Bottom View =================== ///
class PersonalMessageBottomView extends StatelessWidget {
  const PersonalMessageBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<PersonalChatController>(
        id: Constant.idGetOldChat,
        builder: (logic) {
          return logic.isLoading
              ? Shimmers.getOldChatShimmer()
              : Obx(
                  () {
                    SocketManager.onChatUpdate();

                    return SingleChildScrollView(
                      controller: SocketManager.scrollController,
                      child: ListView.builder(
                        itemCount: SocketManager.setMessageList.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String inputDateString = SocketManager.setMessageList[index].date ?? "";
                          DateTime parsedDateTime = DateFormat("M/dd/yyyy, hh:mm:ss a").parse(inputDateString.toUpperCase());
                          String formattedTime = DateFormat("h:mm").format(parsedDateTime);

                          return SocketManager.setMessageList[index].senderId == Constant.storage.read("customerId")
                              ? SocketManager.setMessageList[index].messageType == 1 ||
                                      SocketManager.setMessageList[index].messageType == 4
                                  ? Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        width: Get.width / 1.6,
                                        child: Stack(
                                          alignment: Alignment.centerRight,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(left: 10, right: 22, top: 6, bottom: 10),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryAppColor1,
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                ),
                                              ),
                                              child: Text(
                                                SocketManager.setMessageList[index].message ?? "",
                                                style: AppFontStyle.fontStyleW700(
                                                  fontSize: 15,
                                                  fontColor: AppColors.white,
                                                ),
                                              ).paddingOnly(bottom: 5),
                                            ),
                                            Positioned(
                                              bottom: 2,
                                              right: 8,
                                              child: Text(
                                                formattedTime,
                                                style: AppFontStyle.fontStyleW600(
                                                  fontSize: 9,
                                                  fontColor: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).paddingOnly(bottom: 8, right: 15),
                                    )
                                  : SocketManager.setMessageList[index].messageType == 2
                                      ? Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(18),
                                                topLeft: Radius.circular(18),
                                                bottomLeft: Radius.circular(18),
                                              ),
                                              color: AppColors.primaryAppColor1,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.black.withOpacity(0.08),
                                                  blurRadius: 2,
                                                  spreadRadius: 1.5,
                                                  offset: const Offset(0.3, 0.4),
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.dialog(
                                                      barrierColor: AppColors.black.withOpacity(0.8),
                                                      Stack(
                                                        children: [
                                                          Dialog(
                                                            backgroundColor: AppColors.transparent,
                                                            shadowColor: Colors.transparent,
                                                            surfaceTintColor: Colors.transparent,
                                                            elevation: 0,
                                                            child: ImageViewDialog(
                                                              image:
                                                                  "${ApiConstant.BASE_URL}${SocketManager.setMessageList[index].image}",
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            child: Align(
                                                              alignment: Alignment.topRight,
                                                              child: Image.asset(
                                                                AppAsset.icClose,
                                                                height: 35,
                                                              ),
                                                            ).paddingOnly(right: 20),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: Get.height * 0.2,
                                                    width: Get.width * 0.36,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.divider,
                                                      borderRadius: const BorderRadius.only(
                                                        topRight: Radius.circular(15),
                                                        topLeft: Radius.circular(15),
                                                        bottomLeft: Radius.circular(15),
                                                      ),
                                                    ),
                                                    clipBehavior: Clip.hardEdge,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "${ApiConstant.BASE_URL}${SocketManager.setMessageList[index].image}",
                                                      fit: BoxFit.cover,
                                                      placeholder: (context, url) {
                                                        return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                                                      },
                                                      errorWidget: (context, url, error) {
                                                        return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                                                      },
                                                    ),
                                                  ).paddingOnly(bottom: 5),
                                                ),
                                                Text(
                                                  "${EnumLocale.txtSendOn.name.tr} $formattedTime",
                                                  style: AppFontStyle.fontStyleW600(
                                                    fontSize: 9,
                                                    fontColor: AppColors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ).paddingOnly(right: 15, bottom: 8),
                                        )
                                      : Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(18),
                                                topLeft: Radius.circular(18),
                                                bottomLeft: Radius.circular(18),
                                              ),
                                              color: AppColors.primaryAppColor1,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.black.withOpacity(0.08),
                                                  blurRadius: 2,
                                                  spreadRadius: 1.5,
                                                  offset: const Offset(0.3, 0.4),
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      AppRoutes.videoPlayer,
                                                      arguments: [
                                                        "${ApiConstant.BASE_URL}${SocketManager.setMessageList[index].video}"
                                                      ],
                                                    );
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        height: Get.height * 0.2,
                                                        width: Get.width * 0.36,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.divider,
                                                          borderRadius: const BorderRadius.only(
                                                            topRight: Radius.circular(15),
                                                            topLeft: Radius.circular(15),
                                                            bottomLeft: Radius.circular(15),
                                                          ),
                                                        ),
                                                        clipBehavior: Clip.hardEdge,
                                                        child: CachedNetworkImage(
                                                          imageUrl:
                                                              "${ApiConstant.BASE_URL}${SocketManager.setMessageList[index].image}",
                                                          fit: BoxFit.cover,
                                                          placeholder: (context, url) {
                                                            return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                                                          },
                                                          errorWidget: (context, url, error) {
                                                            return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                                                          },
                                                        ),
                                                      ).paddingOnly(bottom: 5),
                                                      const Positioned(
                                                        top: 25,
                                                        bottom: 25,
                                                        right: 25,
                                                        left: 25,
                                                        child: Icon(
                                                          Icons.play_circle,
                                                          color: Colors.white54,
                                                          size: 50,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "${EnumLocale.txtSendOn.name.tr} $formattedTime",
                                                  style: AppFontStyle.fontStyleW600(
                                                    fontSize: 9,
                                                    fontColor: AppColors.white,
                                                  ),
                                                ).paddingOnly(right: 5),
                                              ],
                                            ),
                                          ).paddingOnly(bottom: 8, right: 15),
                                        )
                              : SocketManager.setMessageList[index].messageType == 1 ||
                                      SocketManager.setMessageList[index].messageType == 4
                                  ? Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width / 1.6,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Stack(
                                              alignment: Alignment.centerLeft,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.only(left: 10, right: 22, top: 6, bottom: 10),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.divider,
                                                    borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    SocketManager.setMessageList[index].message ?? "",
                                                    style: AppFontStyle.fontStyleW700(
                                                      fontSize: 15,
                                                      fontColor: AppColors.categoryText,
                                                    ),
                                                  ).paddingOnly(bottom: 5),
                                                ),
                                                Positioned(
                                                  bottom: 2,
                                                  right: 10,
                                                  child: Text(
                                                    formattedTime,
                                                    style: AppFontStyle.fontStyleW600(
                                                      fontSize: 9,
                                                      fontColor: AppColors.categoryText,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ).paddingOnly(bottom: 10, left: 15),
                                      ],
                                    )
                                  : SocketManager.setMessageList[index].messageType == 2
                                      ? Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(18),
                                                topLeft: Radius.circular(18),
                                                bottomRight: Radius.circular(18),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.black.withOpacity(0.08),
                                                  blurRadius: 2,
                                                  spreadRadius: 1.5,
                                                  offset: const Offset(0.3, 0.4),
                                                )
                                              ],
                                              color: AppColors.divider,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.dialog(
                                                      barrierColor: AppColors.black.withOpacity(0.8),
                                                      Stack(
                                                        children: [
                                                          Dialog(
                                                            backgroundColor: AppColors.transparent,
                                                            shadowColor: Colors.transparent,
                                                            surfaceTintColor: Colors.transparent,
                                                            elevation: 0,
                                                            child: ImageViewDialog(
                                                              image:
                                                                  "${ApiConstant.BASE_URL}${SocketManager.setMessageList[index].image}",
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment.topRight,
                                                            child: Image.asset(
                                                              AppAsset.icClose,
                                                              height: 35,
                                                            ),
                                                          ).paddingOnly(top: 30, right: 20),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: Get.height * 0.2,
                                                    width: Get.width * 0.36,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius: const BorderRadius.only(
                                                        topRight: Radius.circular(15),
                                                        topLeft: Radius.circular(15),
                                                        bottomRight: Radius.circular(15),
                                                      ),
                                                    ),
                                                    clipBehavior: Clip.hardEdge,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "${ApiConstant.BASE_URL}${SocketManager.setMessageList[index].image ?? ""}",
                                                      fit: BoxFit.cover,
                                                      placeholder: (context, url) {
                                                        return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                                                      },
                                                      errorWidget: (context, url, error) {
                                                        return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                                                      },
                                                    ),
                                                  ).paddingOnly(bottom: 5),
                                                ),
                                                Text(
                                                  "${EnumLocale.txtSendOn.name.tr} $formattedTime",
                                                  style: AppFontStyle.fontStyleW700(
                                                    fontSize: 10,
                                                    fontColor: AppColors.categoryText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ).paddingOnly(left: 15, bottom: 10),
                                        )
                                      : Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(18),
                                                topLeft: Radius.circular(18),
                                                bottomRight: Radius.circular(18),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.black.withOpacity(0.08),
                                                  blurRadius: 2,
                                                  spreadRadius: 1.5,
                                                  offset: const Offset(0.3, 0.4),
                                                )
                                              ],
                                              color: AppColors.divider,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      AppRoutes.videoPlayer,
                                                      arguments: [
                                                        "${ApiConstant.BASE_URL}${SocketManager.setMessageList[index].video}"
                                                      ],
                                                    );
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        height: Get.height * 0.2,
                                                        width: Get.width * 0.36,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.white,
                                                          borderRadius: const BorderRadius.only(
                                                            topRight: Radius.circular(15),
                                                            topLeft: Radius.circular(15),
                                                            bottomRight: Radius.circular(15),
                                                          ),
                                                        ),
                                                        clipBehavior: Clip.hardEdge,
                                                        child: CachedNetworkImage(
                                                          imageUrl:
                                                              "${ApiConstant.BASE_URL}${SocketManager.setMessageList[index].image ?? ""}",
                                                          fit: BoxFit.cover,
                                                          placeholder: (context, url) {
                                                            return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                                                          },
                                                          errorWidget: (context, url, error) {
                                                            return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                                                          },
                                                        ),
                                                      ).paddingOnly(bottom: 5),
                                                      const Positioned(
                                                        top: 25,
                                                        bottom: 25,
                                                        right: 25,
                                                        left: 25,
                                                        child: Icon(
                                                          Icons.play_circle,
                                                          color: Colors.white54,
                                                          size: 50,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "${EnumLocale.txtSendOn.name.tr} $formattedTime",
                                                  style: AppFontStyle.fontStyleW700(
                                                    fontSize: 10,
                                                    fontColor: AppColors.categoryText,
                                                  ),
                                                ).paddingOnly(right: 5),
                                              ],
                                            ),
                                          ).paddingOnly(left: 15, bottom: 10),
                                        );
                        },
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}

/// =================== Bottom View =================== ///
class PersonalChatBottomView extends StatelessWidget {
  const PersonalChatBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.1,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(
              3.0,
              3.0,
            ),
            blurRadius: 8.0,
          ), //BoxShadow
        ],
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<PersonalChatController>(
            builder: (logic) {
              return SizedBox(
                height: 50,
                width: Get.width * 0.8,
                child: TextFormField(
                  controller: logic.chatController,
                  cursorColor: AppColors.ratingMessage,
                  style: AppFontStyle.fontStyleW600(
                    fontSize: 13,
                    fontColor: AppColors.ratingMessage,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: BorderSide(color: AppColors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        if (logic.chatController.text.isNotEmpty) {
                          logic.sendMessage(messageType: 1);
                          logic.chatController.clear();
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryAppColor1,
                        ),
                        child: Image.asset(AppAsset.icSend).paddingAll(9),
                      ).paddingOnly(right: 7),
                    ),
                    fillColor: AppColors.divider,
                    filled: true,
                    hintText: EnumLocale.txtTypeSomething.name.tr,
                    hintStyle: AppFontStyle.fontStyleW600(
                      fontSize: 15,
                      fontColor: AppColors.tabUnselectText,
                    ),
                  ),
                ),
              );
            },
          ),
          GetBuilder<PersonalChatController>(
            builder: (logic) {
              return SpeedDial(
                mini: false,
                openCloseDial: logic.isDialOpen,
                childPadding: const EdgeInsets.only(left: 12),
                dialRoot: (ctx, open, toggleChildren) {
                  return GestureDetector(
                    onTap: toggleChildren,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryAppColor1,
                      ),
                      child: logic.isDialOpen.value == true
                          ? Image.asset(AppAsset.icCross).paddingAll(10)
                          : Image.asset(AppAsset.icClip).paddingAll(11.5),
                    ),
                  );
                },
                elevation: 0,
                animationCurve: Curves.easeIn,
                isOpenOnStart: false,
                overlayOpacity: 0,
                children: [
                  SpeedDialChild(
                    elevation: 0,
                    backgroundColor: AppColors.transparent,
                    child: GetBuilder<PersonalChatController>(
                      id: Constant.idChatImage,
                      builder: (logic) {
                        return GestureDetector(
                          onTap: () {
                            logic.onPickImage();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryAppColor1,
                            ),
                            child: Image.asset(AppAsset.icImage, color: AppColors.white).paddingAll(10),
                          ),
                        );
                      },
                    ),
                  ),
                  SpeedDialChild(
                    elevation: 0,
                    backgroundColor: AppColors.transparent,
                    child: GetBuilder<PersonalChatController>(
                      id: Constant.idChatVideo,
                      builder: (logic) {
                        return GestureDetector(
                          onTap: () {
                            logic.onPickVideo();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryAppColor1,
                            ),
                            child: Image.asset(AppAsset.icVideo).paddingAll(10),
                          ),
                        );
                      },
                    ),
                  ),
                  SpeedDialChild(
                    elevation: 0,
                    backgroundColor: AppColors.transparent,
                    child: GetBuilder<PersonalChatController>(
                      id: Constant.idChatCameraPhoto,
                      builder: (logic) {
                        return GestureDetector(
                          onTap: () {
                            logic.onPickCameraImage();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryAppColor1,
                            ),
                            child: Image.asset(AppAsset.icCamera).paddingAll(10.5),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
