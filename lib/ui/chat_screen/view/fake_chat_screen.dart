import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/chat_screen/model/fake_chat_thumb_list_model.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/font_style.dart';

class FakeChatScreen extends StatelessWidget {
  final List<FakeChatItem> fakeChatItem;

  const FakeChatScreen({super.key, required this.fakeChatItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: fakeChatItem.length,
        itemBuilder: (context, index) {
          final chatItem = fakeChatItem[index];
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 400),
            columnCount: fakeChatItem.length,
            child: SlideAnimation(
              child: FadeInAnimation(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.fakePersonalChat,
                          arguments: [
                            chatItem.name,
                            chatItem.thumbUrl,
                            chatItem.serviceName,
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
                              imageUrl: chatItem.thumbUrl,
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
                                      chatItem.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFontStyle.fontStyleW900(
                                        fontSize: 17,
                                        fontColor: AppColors.appButton,
                                      ),
                                    ),
                                    Text(
                                      chatItem.time,
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
                                        chatItem.lastMessage,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFontStyle.fontStyleW500(
                                          fontSize: 13.5,
                                          fontColor: AppColors.categoryText,
                                        ),
                                      ),
                                    ),
                                    chatItem.unreadCount == 0
                                        ? const SizedBox()
                                        : Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(color: AppColors.appButton, shape: BoxShape.circle),
                                            child: Center(
                                              child: Text(
                                                chatItem.unreadCount.toString(),
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
                ),
              ),
            ),
          );
        },
      ).paddingOnly(top: 12),
    );
  }
}
