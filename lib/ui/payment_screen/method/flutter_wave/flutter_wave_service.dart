import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:handy/ui/my_wallet_screen/controller/my_wallet_controller.dart';
import 'package:handy/ui/payment_screen/controller/payment_screen_controller.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';

class FlutterWaveService {
  PaymentScreenController paymentScreenController = Get.find<PaymentScreenController>();
  MyWalletController myWalletController = Get.find<MyWalletController>();

  String? customerId;
  String? amount;
  String? paymentGateway;
  String? couponId;
  String userEmail = Constant.storage.read('customerEmail') ?? "";
  String userContactNumber = Constant.storage.read('mobileNumber') ?? "";

  init({
    required String flutterWavePublishKey,
    required String customerId,
    required String amount,
    required String paymentGateway,
    required String couponId,
  }) {
    flutterWavePublishKey = flutterWavePublishKey;
    this.customerId = customerId;
    this.amount = amount;
    this.paymentGateway = paymentGateway;
    this.couponId = couponId;
  }

  Future handlePaymentSuccess() async {
    await paymentScreenController.depositWalletApiCall(
      customerId: customerId ?? "",
      amount: amount ?? "",
      paymentGateway: paymentGateway ?? "",
      couponId: couponId ?? "",
    );

    if (paymentScreenController.depositWalletModel?.status == true) {
      paymentScreenController.onPayment();
      Utils.showToast(Get.context!, paymentScreenController.depositWalletModel?.message ?? "");
    } else {
      Utils.showToast(Get.context!, paymentScreenController.depositWalletModel?.message ?? "");
    }
  }

  void handlePaymentInitialization(BuildContext context) async {
    final Customer customer = Customer(name: "Handy", phoneNumber: userContactNumber.toString(), email: userEmail);

    log("Flutter Wave Start");
    final Flutterwave flutterWave = Flutterwave(

      publicKey: flutterWaveKey ?? "",
      currency: currency ?? "",
      redirectUrl: "https://www.google.com/",
      txRef: DateTime.now().microsecond.toString(),
      amount: amount.toString(),
      customer: customer,
      paymentOptions: "ussd, card, barter, payattitude",
      customization: Customization(title: EnumLocale.txtAppName.name.tr),
      isTestMode: true,
    );
    log("Flutter Wave Finish");

    final ChargeResponse response = await flutterWave.charge(context);
    log("Flutter Wave response :: $response");
    Utils.showToast(Get.context!, "Payment ${response.status.toString()}");

    if (response.success == true) {
      handlePaymentSuccess();
    }
  }
}
