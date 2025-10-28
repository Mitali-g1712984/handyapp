import 'package:flutter/material.dart';
import 'package:handy/ui/fake_personal_chat_screen/widget/fake_personal_chat_widget.dart';

class FakePersonalChatScreen extends StatelessWidget {
  const FakePersonalChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: FakePersonalChatTopView(),
      ),
      body: FakePersonalChatMessageView(),
    );
  }
}
