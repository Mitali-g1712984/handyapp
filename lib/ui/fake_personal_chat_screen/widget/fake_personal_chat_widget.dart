import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/fake_personal_chat_screen/controller/fake_personal_chat_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/utils.dart';

/// =================== Top View =================== ///
class FakePersonalChatTopView extends StatelessWidget {
  const FakePersonalChatTopView({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: Get.height * 0.10 + statusBarHeight,
      width: Get.width,
      padding: EdgeInsets.only(top: statusBarHeight - 10),
      color: AppColors.primaryAppColor1,
      child: GetBuilder<FakePersonalChatController>(
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
                height: 50,
                width: 50,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    logic.agencyName ?? "",
                    style: AppFontStyle.fontStyleW900(
                      fontSize: 18,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(bottom: 3),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Text(
                      logic.serviceName ?? "",
                      style: AppFontStyle.fontStyleW600(
                        fontSize: 10,
                        fontColor: AppColors.appButton,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.fakeCallConnect,
                    arguments: [
                      logic.agencyName,
                      logic.agencyImage,
                    ],
                  );
                },
                child: Image.asset(
                  AppAsset.icCall1,
                  height: 24,
                  width: 24,
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
class FakePersonalChatMessageView extends StatelessWidget {
  const FakePersonalChatMessageView({super.key});

  @override
  Widget build(BuildContext context) {
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
          FakePersonalMessageBottomView(),
          FakePersonalChatBottomView(),
        ],
      ),
    );
  }
}

/// =================== Bottom View =================== ///
class FakePersonalMessageBottomView extends StatelessWidget {
  const FakePersonalMessageBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<FakePersonalChatController>(
        builder: (logic) {
          return ListView.builder(
            itemCount: logic.chatMessages.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final chatMessage = logic.chatMessages[index];

              return chatMessage.isSentByMe == true
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
                                chatMessage.message,
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
                                logic.formatTime(chatMessage.time),
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
                  : Row(
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
                                    chatMessage.message,
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
                                    logic.formatTime(chatMessage.time),
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
                    );
            },
          ).paddingOnly(top: 10, bottom: 10);
        },
      ),
    );
  }
}

/// =================== Bottom View =================== ///
class FakePersonalChatBottomView extends StatelessWidget {
  const FakePersonalChatBottomView({super.key});

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
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GetBuilder<FakePersonalChatController>(
        builder: (logic) {
          return Center(
            child: SizedBox(
              height: 50,
              width: Get.width,
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
                      logic.chatController.clear();
                      Utils.showToast(context, "Oops! you don't have permission.This is demo login");
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
            ),
          );
        },
      ),
    );
  }
}
