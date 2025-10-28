import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/chat_screen/controller/chat_screen_controller.dart';
import 'package:handy/ui/chat_screen/model/get_chat_list_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class ChatAppBarView extends StatelessWidget {
  const ChatAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMessage.name.tr,
      showLeadingIcon: false,
    );
  }
}

/// =================== Chat ListView =================== ///
class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatScreenController>(
      id: Constant.idGetChatList,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.getChatThumbListShimmer()
            : logic.getChatListModel?.chatList?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icNoDataChat,
                    imageHeight: 200,
                    text: EnumLocale.noDataFoundHistory.name.tr,
                  )
                : ListView.builder(
                    itemCount: logic.getChatListModel?.chatList?.length ?? 0,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 400),
                        columnCount: logic.getChatListModel?.chatList?.length ?? 0,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: ChatListItemView(
                              chatList: logic.getChatListModel?.chatList?[index] ?? ChatList(),
                            ),
                          ),
                        ),
                      );
                    },
                  ).paddingOnly(top: 12);
      },
    );
  }
}

class ChatListItemView extends StatelessWidget {
  final ChatList chatList;
  const ChatListItemView({super.key, required this.chatList});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatScreenController>(
      builder: (logic) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.personalChat,
                  arguments: [
                    chatList.receiverId,
                    chatList.name,
                    chatList.profileImage,
                    chatList.receiverRole,
                  ],
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.divider.withOpacity(0.5),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${chatList.profileImage}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                      },
                    ),
                  ).paddingOnly(left: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              chatList.name ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: AppFontStyle.fontStyleW900(
                                fontSize: 17,
                                fontColor: AppColors.appButton,
                              ),
                            ),
                            Text(
                              chatList.time ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: AppFontStyle.fontStyleW700(
                                fontSize: 11,
                                fontColor: AppColors.categoryText,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * 0.6,
                              child: Text(
                                chatList.message ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: AppFontStyle.fontStyleW500(
                                  fontSize: 13.5,
                                  fontColor: AppColors.categoryText,
                                ),
                              ),
                            ),
                            chatList.unreadCount == 0
                                ? const SizedBox()
                                : Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(color: AppColors.appButton, shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        chatList.unreadCount.toString(),
                                        style: AppFontStyle.fontStyleW700(
                                          fontSize: 14,
                                          fontColor: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        )
                      ],
                    ).paddingOnly(left: 12, right: 13),
                  )
                ],
              ),
            ),
            Divider(height: 1.2, color: AppColors.border.withOpacity(0.3)).paddingOnly(top: 9, bottom: 9)
          ],
        );
      },
    );
  }
}
