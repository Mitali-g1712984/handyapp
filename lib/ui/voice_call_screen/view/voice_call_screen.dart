import 'package:flutter/material.dart';
import 'package:handy/ui/voice_call_screen/widget/voice_call_widget.dart';
import 'package:handy/utils/app_color.dart';

class VoiceCallScreen extends StatelessWidget {
  const VoiceCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: const VoiceCallView(),
    );
  }
}
