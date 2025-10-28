import 'package:get/get.dart';
import 'package:handy/custom/dialog/exit_app_dialog.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/home_screen/widget/home_screen_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Get.dialog(
          barrierColor: AppColors.black.withOpacity(0.8),
          Dialog(
            backgroundColor: AppColors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            child: const ExitAppDialog(),
          ),
        );
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: HomeTopView(),
        ),
        body: GetBuilder<HomeScreenController>(
          id: Constant.idGetTopRatedAgency,
          builder: (logic) {
            return RefreshIndicator(
              onRefresh: () => logic.onRefreshData(),
              color: AppColors.primaryAppColor1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    logic.getUpcomingAppointmentModel?.data?.isEmpty == true ? const SizedBox() : const MyAppointmentTitleView(),
                    logic.getUpcomingAppointmentModel?.data?.isEmpty == true ? const SizedBox() : const MyAppointmentItemView(),
                    (logic.getUpcomingAppointmentModel?.data?.length ?? 0) > 1
                        ? const MyAppointmentIndicator()
                        : const SizedBox(),
                    const HomeBannerTitleView(),
                    const HomeBannerView(),
                    const HomeCategoryTitleView(),
                    const HomeCategoryView(),
                    logic.getTopRatedAgencyModel?.data?.isEmpty == true ? const SizedBox() : const HomeTopRatedTitleView(),
                    logic.getTopRatedAgencyModel?.data?.isEmpty == true ? const SizedBox() : const HomeTopRatedListView(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
