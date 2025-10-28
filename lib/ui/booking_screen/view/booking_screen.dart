import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/booking_screen/controller/booking_screen_controller.dart';
import 'package:handy/ui/booking_screen/widget/booking_screen_widget.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingScreenController>(
      id: Constant.idGetAppointmentTime,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading1,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const BookingAppBarView(),
            ),
            bottomNavigationBar: logic.getAppointmentTimeModel?.isOpen == true
                ? const BookingBottomView()
                : const SizedBox(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BookingInfoView(),
                  const BookingDateView(),
                  if (logic.getAppointmentTimeModel?.isOpen == true) ...[
                    const BookingSlotView(),
                    const BookingProblemView(),
                    const BookingUploadPhotoView(),
                  ] else ...[
                    NoDataFound(
                      image: AppAsset.icPlaceholderNoData,
                      imageHeight: 200,
                      text: "Today is holiday!!",
                    ).paddingOnly(top: Get.height * 0.07),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
