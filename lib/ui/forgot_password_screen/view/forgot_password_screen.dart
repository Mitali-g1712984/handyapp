import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/forgot_password_screen/controller/forgot_password_controller.dart';
import 'package:handy/ui/forgot_password_screen/widget/forgot_password_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      id: Constant.idGenerateOtpForPassword,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const ForgotPasswordAppBarView(),
              elevation: 0,
            ),
            bottomNavigationBar: const ForgotPasswordBottomView(),
            body: const Column(
              children: [
                ForgotPasswordDesView(),
                ForgotPasswordEmailView(),
              ],
            ).paddingAll(15),
          ),
        );
      },
    );
  }
}
