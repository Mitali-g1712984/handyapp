import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/verify_otp_screen/controller/verify_otp_controller.dart';
import 'package:handy/ui/verify_otp_screen/widget/verify_otp_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOtpController>(
        id: Constant.idLoginOrSignUp,
        builder: (logic) {
          return ProgressDialog(
            inAsyncCall: logic.isLoading,
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: const VerifyOtpAppBarView(),
              ),
              body: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerifyOtpDescriptionView(),
                  VerifyOtpDesEmailView(),
                  VerifyOtpView(),
                  VerifyOtpResendOTPView(),
                  Spacer(),
                  VerifyOtpButtonView(),
                ],
              ).paddingOnly(left: 18, right: 18, top: 18),
            ),
          );
        });
  }
}
