import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/personal_chat_screen/widget/personal_chat_widget.dart';
import 'package:handy/utils/app_color.dart';

class PersonalChatScreen extends StatelessWidget {
  const PersonalChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: PersonalChatTopView(),
      ),
      body: const PersonalChatMessageView().paddingOnly(top: 10),
    );
  }
}
