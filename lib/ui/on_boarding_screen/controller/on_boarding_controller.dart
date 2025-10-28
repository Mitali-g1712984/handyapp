import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/constant.dart';

class OnBoardingController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  List title = [
    'We Provide Professional Service At A Friendly Price',
    'The Best Results And Your Satisfaction Is Our Top Priority',
    'Let\'s Make Awesome Changes To Your Home',
  ];

  List image = [
    AppAsset.imImage1,
    AppAsset.imImage2,
    AppAsset.imImage3,
  ];

  onPageScroll({required int currentPage}) {
    if (currentPage < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Constant.storage.write("isOnBoarding", true);
      Get.offAllNamed(AppRoutes.main);
    }
    update([Constant.idOnBoarding]);
  }

  onPageChanged({required int page}) {
    currentPage = page;
    update([Constant.idOnBoarding]);
  }
}
