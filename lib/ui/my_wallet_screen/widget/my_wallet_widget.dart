import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/bottom_sheet/payment_bottom_sheet.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/history_screen/controller/history_screen_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/global_variables.dart';

/// =================== App Bar =================== ///
class MyWalletAppBarView extends StatelessWidget {
  const MyWalletAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyWallet.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Current Balance =================== ///
class MyWalletBalanceView extends StatelessWidget {
  const MyWalletBalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: Get.width,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage(AppAsset.imWalletBox),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            EnumLocale.txtAvailableBalance.name.tr,
            style: AppFontStyle.fontStyleW600(
              fontSize: 16,
              fontColor: AppColors.white,
            ),
          ),
          GetBuilder<HistoryScreenController>(
            id: Constant.idGetWalletHistory,
            builder: (logic) {
              return Text(
                "$currency ${walletAmount ?? "${Constant.storage.read("walletAmount") ?? 0.0}"}",
                style: AppFontStyle.fontStyleW900(
                  fontSize: 28,
                  fontColor: AppColors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// =================== Button =================== ///
class MyWalletButtonView extends StatelessWidget {
  const MyWalletButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryAppButton(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const PaymentBottomSheet(isRecharge: true);
                },
              );
            },
            height: 48,
            borderRadius: 8,
            text: EnumLocale.txtAddAmount.name.tr,
            textStyle: AppFontStyle.fontStyleW800(
              fontSize: 16,
              fontColor: AppColors.primaryAppColor1,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: PrimaryAppButton(
            onTap: () {
              Get.toNamed(AppRoutes.history);
            },
            height: 48,
            borderRadius: 8,
            color: AppColors.redBox,
            text: EnumLocale.txtWalletHistory.name.tr,
            textStyle: AppFontStyle.fontStyleW800(
              fontSize: 16,
              fontColor: AppColors.white,
            ),
          ),
        )
      ],
    ).paddingOnly(left: 12, right: 12);
  }
}
