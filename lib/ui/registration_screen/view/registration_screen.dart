import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/registration_screen/controller/registration_controller.dart';
import 'package:handy/ui/registration_screen/widget/registration_screen_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
        id: Constant.idGenerateOtpForLogin,
        builder: (logic) {
          return ProgressDialog(
            inAsyncCall: logic.isLoading,
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: const RegistrationAppBarView(),
              ),
              bottomNavigationBar: const RegistrationBottomView(),
              body: SingleChildScrollView(
                child: const Column(
                  children: [
                    RegistrationDesView(),
                    RegistrationAddInfoView(),
                  ],
                ).paddingOnly(left: 18, right: 18, top: 18, bottom: 18),
              ),
            ),
          );
        });
  }
}
