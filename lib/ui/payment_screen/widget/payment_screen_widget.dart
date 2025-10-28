import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/ui/payment_screen/controller/payment_screen_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/global_variables.dart';

/// =================== App Bar =================== ///
class PaymentAppBarView extends StatelessWidget {
  const PaymentAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtPayment.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Title =================== ///
class PaymentTitleView extends StatelessWidget {
  const PaymentTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.txtSelectPaymentMethod.name.tr,
      style: AppFontStyle.fontStyleW900(
        fontSize: 16,
        fontColor: AppColors.appButton,
      ),
    ).paddingOnly(top: 15, left: 15, bottom: 15);
  }
}

/// =================== Payment List =================== ///
class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isRazorPay == true ? const RazorpayPaymentView() : const SizedBox(),
        isStripePay == true ? const StripePaymentView() : const SizedBox(),
        isFlutterWave == true ? const FlutterWavePaymentView() : const SizedBox(),
      ],
    );
  }
}

class RazorpayPaymentView extends StatelessWidget {
  const RazorpayPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentScreenController>(
      id: Constant.idSelectPayment,
      builder: (logic) {
        return InkWell(
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          onTap: () {
            logic.onSelectPayment(0);
          },
          child: Container(
            height: 55,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 1,
                ), //BoxShadow
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: AppColors.specialistBox,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(AppAsset.icRazorpay).paddingAll(7),
                ).paddingOnly(right: 10),
                Text(
                  "Razor Pay",
                  style: AppFontStyle.fontStyleW700(
                    fontSize: 16,
                    fontColor: AppColors.appButton,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: logic.selectPayment == 0 ? AppColors.primaryAppColor1 : AppColors.border,
                      width: 1.2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: logic.selectPayment == 0
                      ? Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.primaryAppColor1,
                            shape: BoxShape.circle,
                          ),
                        )
                      : const SizedBox.shrink(),
                )
              ],
            ).paddingOnly(left: 7, right: 10),
          ).paddingOnly(bottom: 13, left: 15, right: 15),
        );
      },
    );
  }
}

class StripePaymentView extends StatelessWidget {
  const StripePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentScreenController>(
      id: Constant.idSelectPayment,
      builder: (logic) {
        return InkWell(
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          onTap: () {
            logic.onSelectPayment(1);
          },
          child: Container(
            height: 55,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 1,
                ), //BoxShadow
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: AppColors.specialistBox,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(AppAsset.icStripe).paddingAll(7),
                ).paddingOnly(right: 10),
                Text(
                  "Stripe",
                  style: AppFontStyle.fontStyleW700(
                    fontSize: 16,
                    fontColor: AppColors.appButton,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: logic.selectPayment == 1 ? AppColors.primaryAppColor1 : AppColors.border,
                      width: 1.2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: logic.selectPayment == 1
                      ? Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.primaryAppColor1,
                            shape: BoxShape.circle,
                          ),
                        )
                      : const SizedBox.shrink(),
                )
              ],
            ).paddingOnly(left: 7, right: 10),
          ).paddingOnly(bottom: 13, left: 15, right: 15),
        );
      },
    );
  }
}

class FlutterWavePaymentView extends StatelessWidget {
  const FlutterWavePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentScreenController>(
      id: Constant.idSelectPayment,
      builder: (logic) {
        return InkWell(
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          onTap: () {
            logic.onSelectPayment(2);
          },
          child: Container(
            height: 55,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 1,
                ), //BoxShadow
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: AppColors.specialistBox,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(AppAsset.icFlutterWave).paddingAll(7),
                ).paddingOnly(right: 10),
                Text(
                  "Flutter Wave",
                  style: AppFontStyle.fontStyleW700(
                    fontSize: 16,
                    fontColor: AppColors.appButton,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: logic.selectPayment == 2 ? AppColors.primaryAppColor1 : AppColors.border,
                      width: 1.2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: logic.selectPayment == 2
                      ? Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.primaryAppColor1,
                            shape: BoxShape.circle,
                          ),
                        )
                      : const SizedBox.shrink(),
                )
              ],
            ).paddingOnly(left: 7, right: 10),
          ).paddingOnly(bottom: 13, left: 15, right: 15),
        );
      },
    );
  }
}

/// =================== Bottom Bar =================== ///
class PaymentBottomView extends StatelessWidget {
  const PaymentBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentScreenController>(
      id: Constant.idDepositWallet,
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onSelectPaymentMethod(context);
          },
          text: EnumLocale.txtPayNow.name.tr,
          textStyle: AppFontStyle.fontStyleW800(
            fontSize: 17,
            fontColor: AppColors.primaryAppColor1,
          ),
        ).paddingAll(15);
      },
    );
  }
}
