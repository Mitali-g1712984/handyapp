import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/apply_coupon_screen/model/get_coupon_amount_model.dart';
import 'package:handy/ui/apply_coupon_screen/model/get_coupon_model.dart';
import 'package:handy/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;

class ApplyCouponController extends GetxController {
  dynamic args = Get.arguments;

  num? finalAmount;
  int applyCoupon = -1;

  ConfirmBookingController confirmBookingController = Get.find<ConfirmBookingController>();

  @override
  void onInit() async {
    await getDataFromArgs();

    await getCouponApiCall(
      customerId: Constant.storage.read('customerId'),
      type: "2",
      amount: finalAmount.toString(),
    );
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        finalAmount = args[0];
      }

      log("Final Amount Apply Coupon :: $finalAmount");
    }
  }

  onApplyCoupon(int index) {
    if (applyCoupon == index) {
      applyCoupon = -1;
      confirmBookingController.couponCodeAppointment = '';
      Constant.storage.write('couponId', "");
    } else {
      applyCoupon = index;
      confirmBookingController.couponCodeAppointment = getCouponModel?.data?[index].code ?? '';
      Constant.storage.write('couponId', getCouponModel?.data?[index].id);

      log("Coupon Id :: ${Constant.storage.read("couponId")}");
    }
    update([Constant.idApplyCoupon, Constant.idGetCoupon]);
  }

  onBackApplyCouponWithoutSelect() {
    applyCoupon = -1;
    confirmBookingController.couponCodeAppointment = '';
    Constant.storage.write('couponId', "");
    log("Coupon Id :: ${Constant.storage.read("couponId")}");

    confirmBookingController.discountPrice = 0;
    num withOutTax = confirmBookingController.basePrice!;
    num totalServicePrice = (confirmBookingController.basePrice)! - (confirmBookingController.discountPrice)!;
    num taxAmount = ((confirmBookingController.taxRate!) * totalServicePrice) / 100;
    num withTaxAmount = (totalServicePrice) + (taxAmount);

    log("confirmBookingController.taxRate------------ ${confirmBookingController.taxRate}");
    log("withOutTax------------ $withOutTax");
    log("confirmBookingController.discountPrice------------ ${confirmBookingController.discountPrice}");
    log("totalServicePrice------------ $totalServicePrice");
    log("taxAmount------------ $taxAmount");
    log("amount------------ $withTaxAmount");

    confirmBookingController.discountPrice = null;
    confirmBookingController.taxAmount =
        ((confirmBookingController.taxRate!) * (confirmBookingController.totalServicePrice)!) / 100;
    confirmBookingController.finalAmount = (confirmBookingController.totalServicePrice)! + (confirmBookingController.taxAmount)!;

    log("confirmBookingController.taxRate------------ ${confirmBookingController.taxRate}");
    log("confirmBookingController.withOutTax------------ $withOutTax");
    log("confirmBookingController.discountPrice------------ ${confirmBookingController.discountPrice}");
    log("confirmBookingController.totalServicePrice------------ ${confirmBookingController.totalServicePrice}");
    log("confirmBookingController.taxAmount------------ ${confirmBookingController.taxAmount}");
    log("confirmBookingController.amount------------ ${confirmBookingController.finalAmount}");

    confirmBookingController.update([Constant.idAddCouponAmount]);

    update([Constant.idApplyCoupon, Constant.idGetCoupon]);
  }

  onApplyCouponClick() async {
    if (applyCoupon != -1) {
      await getCouponAmountApiCall(
        customerId: Constant.storage.read('customerId'),
        type: "2",
        amount: finalAmount.toString(),
        couponId: confirmBookingController.couponCodeAppointment ?? "",
      );

      if (getCouponAmountModel?.status == true) {
        Utils.showToast(Get.context!, "Coupon apply successfully");
        onAddCouponAmount();

        Constant.storage.write('isApplyCoupon', true);

        Get.back();
        update([Constant.idAddCouponAmount]);
      } else {
        Utils.showToast(Get.context!, getCouponAmountModel?.message ?? "");
      }
    }
  }

  onAddCouponAmount() {
    confirmBookingController.discountPrice = getCouponAmountModel?.data ?? 0;
    log("discount ----------------- ${confirmBookingController.discountPrice}");
    log("Apply Coupon Amount :: ${confirmBookingController.finalAmount}");

    update([Constant.idAddCouponAmount]);
  }

  /// =================== API Calling =================== ///

  GetCouponModel? getCouponModel;
  GetCouponAmountModel? getCouponAmountModel;
  bool isLoading = false;
  bool isLoading1 = false;

  getCouponApiCall({required String customerId, required String type, required String amount}) async {
    try {
      isLoading = true;
      update([Constant.idGetCoupon, Constant.idApplyCoupon]);

      final queryParameters = {
        "customerId": customerId,
        "type": type,
        "amount": amount,
      };

      log("Get Coupon Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getCoupon + queryString);
      log("Get Coupon Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Coupon Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Coupon Status Code :: ${response.statusCode}");
      log("Get Coupon Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getCouponModel = GetCouponModel.fromJson(jsonResponse);
      }

      log("Get Coupon Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Coupon Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetCoupon, Constant.idApplyCoupon]);
    }
  }

  getCouponAmountApiCall({
    required String customerId,
    required String type,
    required String amount,
    required String couponId,
  }) async {
    try {
      isLoading1 = true;
      update([Constant.idGetCouponAmount]);

      final queryParameters = {
        "customerId": customerId,
        "type": type,
        "amount": amount,
        "couponId": couponId,
      };

      log("Get Coupon Amount Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getCouponAmount + queryString);
      log("Get Coupon Amount Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Coupon Amount Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Coupon Amount Status Code :: ${response.statusCode}");
      log("Get Coupon Amount Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getCouponAmountModel = GetCouponAmountModel.fromJson(jsonResponse);
      }

      log("Get Coupon Amount Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Coupon Amount Api :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idGetCouponAmount]);
    }
  }
}
