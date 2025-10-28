import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/verify_password_screen/controller/verify_password_controller.dart';
import 'package:handy/ui/verify_password_screen/widget/verify_password_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class VerifyPasswordScreen extends StatelessWidget {
  const VerifyPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const VerifyPasswordAppBarView(),
      ),
      body: GetBuilder<VerifyPasswordController>(
        id: Constant.idVerifyOTP,
        builder: (logic) {
          return ProgressDialog(
            inAsyncCall: logic.isLoading,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerifyPasswordDescriptionView(),
                VerifyPasswordDesEmailView(),
                VerifyPasswordOTPView(),
                VerifyPasswordResendOTPView(),
                Spacer(),
                VerifyPasswordButtonView(),
              ],
            ).paddingOnly(left: 18, right: 18, top: 18),
          );
        },
      ),
    );
  }
}
