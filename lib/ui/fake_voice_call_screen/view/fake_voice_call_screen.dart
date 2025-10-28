import 'package:flutter/material.dart';
import 'package:handy/ui/fake_voice_call_screen/widget/fake_voice_call_widget.dart';
import 'package:handy/utils/app_color.dart';

class FakeVoiceCallScreen extends StatelessWidget {
  const FakeVoiceCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: const FakeVoiceCallView(),
    );
  }
}
