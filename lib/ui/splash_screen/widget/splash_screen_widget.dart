import 'package:handy/ui/splash_screen/controller/splash_screen_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== Logo View =================== ///
class SplashLogoView extends StatelessWidget {
  const SplashLogoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      builder: (logic) {
        return Container(
          height: Get.height,
          width: Get.width,
          color: AppColors.appButton,
          child: Center(
            child: Image.asset(AppAsset.icLogo, height: 150),
          ),
        );
      },
    );
  }
}
