import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/main_screen/controller/main_screen_controller.dart';
import 'package:handy/ui/main_screen/widget/main_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryAppColor1,
      body: GetBuilder<MainScreenController>(
        id: Constant.idLoginOrSignUp,
        builder: (logic) {
          return ProgressDialog(
            inAsyncCall: logic.isLoading,
            child: const MainDescriptionView(),
          );
        },
      ),
    );
  }
}
