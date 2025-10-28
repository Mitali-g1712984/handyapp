import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/help_task_screen/controller/help_desk_screen_controller.dart';
import 'package:handy/ui/help_task_screen/widget/help_desk_screen_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class HelpDeskScreen extends StatelessWidget {
  const HelpDeskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskScreenController>(
      id: Constant.idRaiseComplain,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              flexibleSpace: const HelpDeskAppBarView(),
            ),
            bottomNavigationBar: const HelpDeskButtonView(),
            body: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HelpDeskAddDateView(),
                  HelpDeskAddImageview(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
