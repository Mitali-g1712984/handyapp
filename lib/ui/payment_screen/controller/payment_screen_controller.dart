import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/history_screen/controller/history_screen_controller.dart';
import 'package:handy/ui/payment_screen/method/flutter_wave/flutter_wave_service.dart';
import 'package:handy/ui/payment_screen/method/razor_Pay/razor_pay_service.dart';
import 'package:handy/ui/payment_screen/method/stripe_payment/stripe_service.dart';
import 'package:handy/ui/payment_screen/model/deposit_wallet_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:handy/utils/utils.dart';
import 'package:intl/intl.dart';

class PaymentScreenController extends GetxController {
  dynamic args = Get.arguments;

  num? amount;
  String? couponId;
  int selectPayment = 0;

  List image = [AppAsset.icRazorpay, AppAsset.icPaypal, AppAsset.icStripe];
  List name = ['Razorpay', 'Paypal', 'Stripe'];

  HistoryScreenController historyScreenController = Get.find<HistoryScreenController>();

  @override
  void onInit() async {
    await getDataFromArgs();

    Stripe.publishableKey = stripePublishKey ?? "";
    await Stripe.instance.applySettings();
    super.onInit();
  }

  getDataFromArgs() {
    log("Payment Screen :: $args");
    if (args != null) {
      if (args[0] != null || args[1] != null) {
        amount = args[0];
        couponId = args[1];
      }
    }

    log("Amount is :: $amount");
    log("Coupon Id when Payment :: $couponId");
  }

  onSelectPayment(int index) {
    selectPayment = index;
    update([Constant.idSelectPayment]);
  }

  onSelectPaymentMethod(BuildContext context) async {
    if (selectPayment == 0) {
      isLoading = true;
      update([Constant.idDepositWallet]);

      RazorPayService().init(
        razorKey: razorpayId ?? "",
        amount: amount.toString(),
        customerId: Constant.storage.read("customerId"),
        paymentGateway: (selectPayment + 1).toString(),
        couponId: "",
      );

      1.seconds.delay;
      isLoading = false;
      update([Constant.idDepositWallet]);

      RazorPayService().razorPayCheckout();
    } else if (selectPayment == 1) {
      isLoading = true;
      update([Constant.idDepositWallet]);

      await StripeService().init();

      1.seconds.delay;
      StripeService().stripePay().then((value) {
        isLoading = false;
        update([Constant.idDepositWallet]);
      }).catchError((e) {
        isLoading = false;
        update([Constant.idDepositWallet]);

        Utils.showToast(Get.context!, e.toString());
      });
    } else if (selectPayment == 2) {
      isLoading = true;
      update([Constant.idDepositWallet]);

      FlutterWaveService().init(
        flutterWavePublishKey: flutterWaveKey ?? "",
        customerId: Constant.storage.read("customerId"),
        amount: amount.toString(),
        paymentGateway: (selectPayment + 1).toString(),
        couponId: "",
      );

      1.seconds.delay;
      isLoading = false;
      update([Constant.idDepositWallet]);

      FlutterWaveService().handlePaymentInitialization(context);
    }
  }

  onPayment() async {
    try {
      isLoading = true;
      update([Constant.idGetWalletHistory]);

      await historyScreenController.getWalletHistoryApiCall(
        customerId: Constant.storage.read('customerId'),
        month: DateFormat('yyyy-MM').format(DateTime.now()),
        start: "1",
        limit: "20",
      );

      if (historyScreenController.getWalletHistoryModel?.status == true) {
        walletAmount = historyScreenController.getWalletHistoryModel?.total;
        Constant.storage.write("walletAmount", historyScreenController.getWalletHistoryModel?.total?.toStringAsFixed(2));

        Get.back();
        Get.back();

        update([Constant.idGetWalletHistory]);
      } else {
        Utils.showToast(Get.context!, historyScreenController.getWalletHistoryModel?.message ?? "");
      }
    } catch (e) {
      log("Error in Payment :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetWalletHistory]);
    }
  }

  /// =================== API Calling =================== ///

  DepositWalletModel? depositWalletModel;
  bool isLoading = false;

  depositWalletApiCall({
    required String customerId,
    required String amount,
    required String paymentGateway,
    required String couponId,
  }) async {
    try {
      isLoading = true;
      update([Constant.idDepositWallet]);

      final queryParameters = {
        "customerId": customerId,
        "amount": amount,
        "paymentGateway": paymentGateway,
        "couponId": couponId,
      };

      log("Deposit Wallet Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.depositWallet + queryString);
      log("Deposit Wallet Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Deposit Wallet Headers :: $headers");

      final response = await http.patch(url, headers: headers);

      log("Deposit Wallet Status Code :: ${response.statusCode}");
      log("Deposit Wallet Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        depositWalletModel = DepositWalletModel.fromJson(jsonResponse);
      }

      log("Deposit Wallet Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Deposit Wallet Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idDepositWallet]);
    }
  }
}
