import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:handy/ui/favorite_agency_screen/controller/favorite_agency_controller.dart';
import 'package:handy/ui/favorite_agency_screen/widget/favorite_agency_widget.dart';
import 'package:handy/utils/app_color.dart';

class FavoriteAgencyScreen extends StatelessWidget {
  const FavoriteAgencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteAgencyController>(
      builder: (logic) {
        return PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (!didPop) {
              if (logic.isBack == false) {
                if (Navigator.canPop(context)) {
                  Get.back();
                }
              } else {
                Get.find<BottomBarController>().onClick(0);
              }
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const FavoriteAgencyAppBarView(),
            ),
            body: const FavoriteAgencyListView(),
          ),
        );
      },
    );
  }
}
