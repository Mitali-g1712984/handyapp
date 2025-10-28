import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/apply_coupon_screen/controller/apply_coupon_controller.dart';
import 'package:handy/ui/apply_coupon_screen/widget/apply_coupon_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class ApplyCouponScreen extends StatelessWidget {
  const ApplyCouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyCouponController>(
      id: Constant.idGetCouponAmount,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading1,
          child: WillPopScope(
            onWillPop: () async{
              logic.onBackApplyCouponWithoutSelect();
              return true;
            },
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: const ApplyCouponAppBarView(),
              ),
              body: const ApplyCouponListView(),
              bottomNavigationBar: logic.getCouponModel?.data?.isEmpty == true ? const SizedBox() : const ApplyCouponBottomView(),
            ),
          ),
        );
      },
    );
  }
}
