import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/device_location_screen/controller/device_location_controller.dart';
import 'package:handy/ui/device_location_screen/widget/device_location_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class DeviceLocationScreen extends StatelessWidget {
  const DeviceLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceLocationController>(
      id: Constant.idGetCurrentLocation,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const DeviceLocationAppBarView(),
            ),
            body: const Column(
              children: [
                DeviceLocationSearchLocationView(),
                Spacer(),
                DeviceLocationMiddleView(),
                Spacer(),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
