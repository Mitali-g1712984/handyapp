import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/payment_screen/controller/payment_screen_controller.dart';
import 'package:handy/ui/payment_screen/widget/payment_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentScreenController>(
      id: Constant.idDepositWallet,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const PaymentAppBarView(),
            ),
            bottomNavigationBar: const PaymentBottomView(),
            body: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaymentTitleView(),
                PaymentView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
