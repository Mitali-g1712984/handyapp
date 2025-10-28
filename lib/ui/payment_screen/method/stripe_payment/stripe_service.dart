import 'dart:convert';
import 'dart:developer';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:handy/ui/my_wallet_screen/controller/my_wallet_controller.dart';
import 'package:handy/ui/payment_screen/controller/payment_screen_controller.dart';
import 'package:handy/ui/payment_screen/method/stripe_payment/stripe_pay_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;

class StripeService {
  String stripeURL = "";
  bool isTest = true;
  PaymentScreenController paymentScreenController = Get.find<PaymentScreenController>();
  MyWalletController myWalletController = Get.find<MyWalletController>();

  init({
    String? stripeURL,
    bool? isTest,
  }) async {
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';

    await Stripe.instance.applySettings().catchError((e) {
      Utils.showToast(Get.context!, e.toString());
      paymentScreenController.isLoading = false;
      throw e.toString();
    });

    this.stripeURL = stripeURL ?? "";
    this.isTest = isTest ?? true;
  }

  Future<dynamic> stripePay() async {
    log("Start Payment Intent http req post method");

    String userId = Constant.storage.read('userId') ?? "";
    String userName = Constant.storage.read('name') ?? "";
    String userEmail = Constant.storage.read('userEmail') ?? "";
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(paymentScreenController.amount.toString()),
        'currency': currencyName,
        'payment_method_types[]': 'card',
      };

      log("Stripe Payment Body :: $body");

      var response = await http.post(
        Uri.parse(ApiConstant.stripeUrl),
        body: body,
        headers: {
          "Authorization": "Bearer $stripeSecretKey",
          "Content-Type": 'application/x-www-form-urlencoded',
        },
      );

      log("End Payment Intent http req post method");

      log("Stripe Payment StatusCode :: ${response.statusCode}");
      log("Stripe Payment Response :: ${response.body.toString()}");

      if (response.statusCode == 200) {
        StripePayModel res = StripePayModel.fromJson(jsonDecode(response.body));
        paymentScreenController.isLoading = true;
        log("Stripe Payment Res :: $res");

        SetupPaymentSheetParameters setupPaymentSheetParameters = SetupPaymentSheetParameters(
          paymentIntentClientSecret: res.clientSecret,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: AppColors.primaryAppColor1,
            ),
          ),
          applePay: PaymentSheetApplePay(
            merchantCountryCode: currency ?? "",
          ),
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: currency ?? "",
            testEnv: isTest,
          ),
          merchantDisplayName: EnumLocale.txtAppName.name.tr,
          customerId: userId.toString(),
          billingDetails: BillingDetails(name: userName, email: userEmail),
        );

        await Stripe.instance.initPaymentSheet(paymentSheetParameters: setupPaymentSheetParameters).then((value) async {
          await Stripe.instance.presentPaymentSheet().then((value) async {
            log("Enter In Stripe Payment Method");

            await paymentScreenController.depositWalletApiCall(
              customerId: Constant.storage.read("customerId"),
              amount: paymentScreenController.amount.toString(),
              paymentGateway: (paymentScreenController.selectPayment + 1).toString(),
              couponId: paymentScreenController.couponId ?? "",
            );

            if (paymentScreenController.depositWalletModel?.status == true) {
              paymentScreenController.onPayment();
              Utils.showToast(Get.context!, paymentScreenController.depositWalletModel?.message ?? "");
            } else {
              Utils.showToast(Get.context!, paymentScreenController.depositWalletModel?.message ?? "");
            }
          }).catchError((e) {
            log("Error In Stripe Method :: $e");
          });

          log("Stripe Method onComplete");
        }).catchError((e) {
          log("Something Went Wrong in Stripe :: $e");

          paymentScreenController.isLoading = false;

          throw 'Something Went Wrong !!';
        });
      } else if (response.statusCode == 401) {
        log("Error During Stripe Payment");
        paymentScreenController.isLoading = false;

        throw 'Something Went Wrong';
      }
      return jsonDecode(response.body);
    } catch (e) {
      log('Error Catch in Stripe :: $e');
    }
  }

  String calculateAmount(String amount) {
    final int calculatedAmount = int.parse(amount) * 100;
    return calculatedAmount.toString();
  }
}