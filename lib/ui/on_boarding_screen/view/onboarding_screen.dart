import 'package:flutter/material.dart';
import 'package:handy/ui/on_boarding_screen/widget/on_boarding_widget.dart';
import 'package:handy/utils/app_color.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryAppColor1,
      body: const OnBoardingView(),
    );
  }
}
