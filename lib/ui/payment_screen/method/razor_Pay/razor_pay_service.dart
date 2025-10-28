import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/payment_screen/controller/payment_screen_controller.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayService {
  static late Razorpay razorPay;
  static late String razorKeys;
  String? amount;
  String? customerId;
  String? paymentGateway;
  String? couponId;
  Function(Map<String, dynamic>)? onComplete;

  PaymentScreenController paymentScreenController = Get.find<PaymentScreenController>();

  init({
    required String razorKey,
    required String amount,
    required String customerId,
    required String paymentGateway,
    required String couponId,
    Function(Map<String, dynamic>)? onComplete,
  }) {
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    razorKeys = razorKey;
    this.onComplete = onComplete;
    this.customerId = customerId;
    this.amount = amount;
    this.couponId = couponId;
    this.paymentGateway = paymentGateway;
  }

  Future handlePaymentSuccess(PaymentSuccessResponse response) async {
    await paymentScreenController.depositWalletApiCall(
      customerId: Constant.storage.read("customerId"),
      amount: paymentScreenController.amount.toString(),
      paymentGateway: paymentGateway!,
      couponId: couponId!,
    );

    if (paymentScreenController.depositWalletModel?.status == true) {
      paymentScreenController.onPayment();
      Utils.showToast(Get.context!, paymentScreenController.depositWalletModel?.message ?? "");
    } else {
      Utils.showToast(Get.context!, paymentScreenController.depositWalletModel?.message ?? "");
    }
  }

  void handlePaymentError(PaymentFailureResponse response) {
    log("response.message================== ${response.message}");
    Utils.showToast(Get.context!, "Payment Cancelled");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Utils.showToast(Get.context!, "External Wallet: ${response.walletName!}");
  }

  void razorPayCheckout() async {
    String userEmail = Constant.storage.read('customerEmail') ?? "";
    String userContactNumber = Constant.storage.read('mobileNumber') ?? "";
    log("RazorPay User Email :: $userEmail");
    log("RazorPay User Mobile Number :: $userContactNumber");

    var options = {
      'key': razorKeys,
      'amount': (double.parse(paymentScreenController.amount.toString()) * 100).toInt().toString(),
      'name': EnumLocale.txtAppName.name.tr,
      'theme.color': '#ADDE34',
      'description': EnumLocale.txtAppName.name.tr,
      'image': 'https://razorpay.com/assets/razorpay-glyph.svg',
      'currency': currencyName,
      'prefill': {'contact': userContactNumber.toString(), 'email': userEmail},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorPay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
