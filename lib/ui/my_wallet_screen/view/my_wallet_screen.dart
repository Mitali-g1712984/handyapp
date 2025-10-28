import 'package:get/get.dart';
import 'package:handy/ui/my_wallet_screen/controller/my_wallet_controller.dart';
import 'package:handy/ui/my_wallet_screen/widget/my_wallet_widget.dart';
import 'package:handy/utils/app_color.dart';

import 'package:flutter/material.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MyWalletAppBarView(),
      ),
      body: GetBuilder<MyWalletController>(
        builder: (logic) {
          return Column(
            children: [
              const MyWalletBalanceView(),
              const MyWalletButtonView(),
              Divider(
                height: Get.height * 0.05,
                color: AppColors.description.withOpacity(0.1),
              ),
            ],
          );
        }
      ),
    );
  }
}
