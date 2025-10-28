import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/mobile_number_screen/widget/mobile_number_widget.dart';
import 'package:handy/utils/app_color.dart';

class MobileNumberScreen extends StatelessWidget {
  const MobileNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MobileNumberAppBarView(),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MobileNumberDescriptionView(),
          MobileNumberOTPView(),
          Spacer(),
          MobileNumberButtonView(),
        ],
      ).paddingOnly(left: 18, right: 18, top: 18),
    );
  }
}
