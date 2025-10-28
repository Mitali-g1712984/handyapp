import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/appointment_screen/widget/appointment_screen_widget.dart';
import 'package:handy/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:handy/utils/app_color.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

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
          flexibleSpace: const AppointmentAppBarView(),
        ),
        body: const AppointmentTabView(),
      ),
    );
  }
}
