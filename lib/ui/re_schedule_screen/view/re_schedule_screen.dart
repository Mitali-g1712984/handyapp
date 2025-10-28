import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/re_schedule_screen/controller/re_schedule_controller.dart';
import 'package:handy/ui/re_schedule_screen/widget/re_schedule_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class ReScheduleScreen extends StatelessWidget {
  const ReScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReScheduleController>(
      id: Constant.idReScheduleAppointment,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading1,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const ReScheduleAppBarView(),
            ),
            bottomNavigationBar: const ReScheduleBottomView(),
            body: const SingleChildScrollView(
              child: Column(
                children: [
                  ReScheduleInfoView(),
                  ReScheduleDateView(),
                  ReScheduleSlotView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
