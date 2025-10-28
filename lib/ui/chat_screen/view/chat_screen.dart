import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:handy/ui/chat_screen/controller/chat_screen_controller.dart';
import 'package:handy/ui/chat_screen/view/fake_chat_screen.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/ui/chat_screen/widget/chat_widget.dart';
import 'package:handy/utils/constant.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Get.find<BottomBarController>().onClick(0);
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: const ChatAppBarView(),
        ),
        body: GetBuilder<ChatScreenController>(
          id: Constant.idGetChatList,
          builder: (logic) {
            return logic.getChatListModel?.chatList?.isEmpty == true
                ? FakeChatScreen(fakeChatItem: logic.chatItems)
                : const ChatListView();
          },
        ),
      ),
    );
  }
}
