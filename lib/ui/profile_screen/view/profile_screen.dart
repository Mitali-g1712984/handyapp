import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/ui/profile_screen/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          flexibleSpace: const ProfileAppBarView(),
        ),
        body: GetBuilder<ProfileScreenController>(
          id: Constant.idGetCustomerProfile,
          builder: (logic) {
            return ProgressDialog(
              inAsyncCall: logic.isLoading,
              child: SingleChildScrollView(
                child: const Column(
                  children: [
                    ProfileInfoView(),
                    ProfileGeneralView(),
                    ProfileAccountView(),
                    ProfileAboutView(),
                  ],
                ).paddingOnly(bottom: 15),
              ),
            );
          },
        ),
      ),
    );
  }
}
