import 'dart:convert';
import 'dart:developer';

import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/apply_coupon_screen/model/get_coupon_amount_model.dart';
import 'package:handy/ui/apply_coupon_screen/model/get_coupon_model.dart';
import 'package:handy/ui/confirm_booking_screen/model/create_booking_by_customer_model.dart';
import 'package:handy/ui/history_screen/controller/history_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConfirmBookingController extends GetxController {
  dynamic args = Get.arguments;

  Color? color;
  Color? textColor;
  String? providerId;
  String? profileImage;
  String? name;
  String? services;
  String? price;
  String? avgRating;
  String? formattedDate;
  String? selectedSlotsList;
  String? serviceController;
  List? imageFileList;
  String? serviceId;
  num? taxRate;
  num? timeSlot;

  ///------------ For add coupon amount
  List<num> priceList = [];
  String? couponCodeAppointment;

  num? basePrice;
  num? taxAmount;
  num? addOnPrice;
  num? finalAmount;
  num? totalServicePrice;
  String? matchingPackageId;
  num? matchingPackagePrice;
  num? discountPrice;
  List<String>? selectedAddOnServiceIds;
  num? selectedAddOnServicePrices;
  int selectAmountIndex = 0;
  int applyCoupon = -1;
  String? couponCode;
  String amount = '50';
  String currencyAmount = '50';
  num? finalAmountAfterCoupon;

  List directAmount = ["50", "100", "150", "200", "250", "300", "350"];
  TextEditingController currencyController = TextEditingController();
  HistoryScreenController historyScreenController = Get.find<HistoryScreenController>();

  @override
  void onInit() async {
    await getDataFromArgs();

    finalAmount = (totalServicePrice ?? 0) + (taxAmount ?? 0);
    log("finalAmount---------- $finalAmount");

    amount = directAmount[0];
    currencyAmount = directAmount[0];
    currencyController.text = amount;

    if (totalServicePrice != null && totalServicePrice != 0) {
      await getCouponApiCall(
        customerId: Constant.storage.read('customerId'),
        type: "2",
        amount: amount,
      );
    }
    await historyScreenController.getWalletHistoryApiCall(
      customerId: Constant.storage.read('customerId'),
      month: DateFormat('yyyy-MM').format(DateTime.now()),
      start: "1",
      limit: "20",
    );

    if (historyScreenController.getWalletHistoryModel?.status == true) {
      Constant.storage.write("walletAmount", historyScreenController.getWalletHistoryModel?.total?.toStringAsFixed(2));
      log("Wallet Amount :: ${Constant.storage.read("walletAmount")}");
    }

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null ||
          args[1] != null ||
          args[2] != null ||
          args[3] != null ||
          args[4] != null ||
          args[5] != null ||
          args[6] != null ||
          args[7] != null ||
          args[8] != null ||
          args[9] != null ||
          args[10] != null ||
          args[11] != null ||
          args[12] != null ||
          args[13] != null ||
          args[14] != null ||
          args[15] != null ||
          args[16] != null ||
          args[17] != null ||
          args[18] != null ||
          args[19] != null ||
          args[20] != null ||
          args[21] != null ||
          args[22] != null ||
          args[23] != null ||
          args[24] != null) {
        color = args[0];
        textColor = args[1];
        providerId = args[2];
        profileImage = args[3];
        name = args[4];
        services = args[5];
        price = args[6];
        avgRating = args[7];
        formattedDate = args[8];
        selectedSlotsList = args[9];
        serviceController = args[10];
        imageFileList = args[11];
        serviceId = args[12];
        taxRate = args[13];
        priceList = args[14];
        selectedAddOnServiceIds = args[15];
        selectedAddOnServicePrices = args[16];
        basePrice = args[17];
        addOnPrice = args[18];
        taxAmount = args[19];
        finalAmount = args[20];
        totalServicePrice = args[21];
        matchingPackageId = args[22];
        matchingPackagePrice = args[23];
        timeSlot = args[24];
      }

      log("Color :: $color");
      log("Text Color :: $textColor");
      log("Provider Id :: $providerId");
      log("Profile Image :: $profileImage");
      log("Name :: $name");
      log("Services :: $services");
      log("Price :: $price");
      log("Avg Rating :: $avgRating");
      log("Selected Date :: $formattedDate");
      log("Selected Slots :: $selectedSlotsList");
      log("Service Controller :: $serviceController");
      log("Image File List :: $imageFileList");
      log("Service Id Confirm Booking :: $serviceId");
      log("Tax Rate Confirm Booking :: $taxRate");
      log("Price List Confirm Booking :: $priceList");
      log("selectedAddOnServiceIds :: $selectedAddOnServiceIds");
      log("selectedAddOnServicePrices :: $selectedAddOnServicePrices");
      log("basePrice :: $basePrice");
      log("addOnPrice :: $addOnPrice");
      log("taxAmount :: $taxAmount");
      log("finalAmount :: $finalAmount");
      log("totalServicePrice :: $totalServicePrice");
      log("matchingPackageId :: $matchingPackageId");
      log("matchingPackagePrice :: $matchingPackagePrice");
      log("timeSlot :: $timeSlot");
    }
  }

  onSelectAmount(int index) async {
    selectAmountIndex = index;
    amount = directAmount[index];
    currencyAmount = directAmount[index];
    currencyController.text = amount;
    applyCoupon = -1;

    log("Currency is :: $currencyAmount");
    log("Amount is :: $amount");
    log("Currency Controller :: ${currencyController.text}");

    update([Constant.idSelectAmount, Constant.idMoneyOffer]);
  }

  void printLatestValue({required String text}) async {
    amount = text;
    currencyController.text = amount;
    applyCoupon = -1;

    log("Amount is :: $amount");
    log("Currency Controller :: ${currencyController.text}");

    update([Constant.idSelectAmount, Constant.idMoneyOffer]);
  }

  onMoneyOffer(int index) {
    final enteredAmount = double.tryParse(amount) ?? 0;
    final couponMinAmount = getCouponModel?.data?[index].minAmountToApply ?? 0;

    if (enteredAmount < couponMinAmount) {
      Utils.showToast(Get.context!, "Recharge with at least $currency$couponMinAmount to activate this coupon.");
      return;
    }

    if (applyCoupon == index) {
      applyCoupon = -1;
      couponCode = '';
      Constant.storage.write('couponId', "");
    } else {
      applyCoupon = index;
      couponCode = getCouponModel?.data?[index].id ?? '';
      Constant.storage.write('couponId', getCouponModel?.data?[index].id);
      onApplyCouponClick();
      log("Coupon Id :: ${Constant.storage.read("couponId")}");
    }
    update([Constant.idGetCoupon, Constant.idApplyCoupon, Constant.idMoneyOffer]);
  }

  onApplyCouponClick() async {
    priceList.add(0);
    priceList.add(0);

    await getCouponAmountApiCall(
      customerId: Constant.storage.read('customerId'),
      type: "1",
      amount: amount,
      couponId: couponCode ?? "",
    );

    if (getCouponAmountModel?.status == true) {
      finalAmountAfterCoupon = (int.parse(amount) - (getCouponAmountModel?.data ?? 0));

      priceList.clear();

      priceList.add(int.parse(amount));
      priceList.add(getCouponAmountModel?.data ?? 0);
      log("-------------- $priceList");

      log("Before Amount :: $amount");
      log("Final Amount After Coupon :: $finalAmountAfterCoupon");

      update([Constant.idMoneyOffer]);
    } else {
      Utils.showToast(Get.context!, getCouponAmountModel?.message ?? "");
    }
  }

  onRechargeClick() {
    if (applyCoupon == -1) {
      Get.toNamed(
        AppRoutes.payment,
        arguments: [
          int.parse(amount),
          Constant.storage.read("couponId"),
        ],
      );
    } else {
      Get.toNamed(
        AppRoutes.payment,
        arguments: [
          finalAmountAfterCoupon,
          Constant.storage.read("couponId"),
        ],
      );
    }
  }

  onPayNowClick() async {
    await createBookingByCustomerApiCall(
      couponId: Constant.storage.read("isApplyCoupon") == true ? Constant.storage.read("couponId") : "",
      customerId: Constant.storage.read('customerId'),
      serviceId: serviceId ?? "",
      agencyId: providerId ?? "",
      date: formattedDate ?? "",
      time: selectedSlotsList ?? "",
      finalAmount: finalAmount.toString(),
      serviceFee: basePrice.toString(),
      serviceInfo: serviceController ?? "",
      image: imageFileList ?? [],
      timeSlot: timeSlot?.toInt() ?? 0,
      addOnServiceId: selectedAddOnServiceIds ?? [],
      packageId: matchingPackageId ?? "",
    );

    if (createBookingByCustomerModel?.status == true) {
      Utils.showToast(Get.context!, createBookingByCustomerModel?.message ?? "");

      Constant.storage.write("couponId", "");
      Constant.storage.write("isApplyCoupon", false);

      Get.offAllNamed(
        AppRoutes.confirmAppointment,
        arguments: [
          color,
          textColor,
          profileImage,
          name,
          services,
          price,
          avgRating,
          formattedDate,
          selectedSlotsList,
        ],
      );
    } else {
      Utils.showToast(Get.context!, createBookingByCustomerModel?.message ?? "");
    }
  }

  /// =================== API Calling =================== ///

  CreateBookingByCustomerModel? createBookingByCustomerModel;
  GetCouponModel? getCouponModel;
  GetCouponAmountModel? getCouponAmountModel;
  bool isLoading = false;
  bool isLoading1 = false;

  createBookingByCustomerApiCall({
    required String couponId,
    required String customerId,
    required String serviceId,
    required String agencyId,
    required String date,
    required String time,
    required String finalAmount,
    required String serviceFee,
    required String serviceInfo,
    required List<String> addOnServiceId,
    required String packageId,
    required int timeSlot,
    required List image,
  }) async {
    try {
      isLoading = true;
      update([Constant.idCreateBookingByCustomer]);

      var uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.createBookingByCustomer);
      var request = http.MultipartRequest("POST", uri);
      log("Create Booking By Customer URL :: $uri");

      if (image.isNotEmpty) {
        for (var file in image) {
          var addPhotoAlbum = await http.MultipartFile.fromPath("image", file.path);
          request.files.add(addPhotoAlbum);
          log("Create Booking By Customer addPhotoAlbum :: $addPhotoAlbum");
          log("Create Booking By Customer Image :: $image");
        }
      }

      request.headers.addAll({"key": ApiConstant.SECRET_KEY});

      Map<String, dynamic> requestBody = <String, dynamic>{
        "couponId": couponId,
        "customerId": customerId,
        "serviceId": serviceId,
        "agencyId": agencyId,
        "date": date,
        "time": time,
        "finalAmount": finalAmount,
        "serviceFee": serviceFee,
        "serviceInfo": serviceInfo,
        "timeSlot": timeSlot,
        if (selectedAddOnServiceIds?.isNotEmpty == true) "addOnServiceId": addOnServiceId.join(","),
        if (matchingPackageId?.isNotEmpty == true) "packageId": packageId,
      };

      log("Create Booking By Customer Body :: $requestBody");

      requestBody.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      log("Create Booking By Customer Status Code :: ${res.statusCode}");
      log("Create Booking By Customer Response :: ${res.body}");

      if (res.statusCode == 200) {
        final jsonResponse = jsonDecode(res.body);
        createBookingByCustomerModel = CreateBookingByCustomerModel.fromJson(jsonResponse);
        return CreateBookingByCustomerModel.fromJson(jsonDecode(res.body));
      }

      log("Create Booking By Customer Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error Call Create Booking By Customer Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idCreateBookingByCustomer]);
    }
  }

  getCouponApiCall({required String customerId, required String type, required String amount}) async {
    try {
      isLoading = true;
      update([Constant.idGetCoupon, Constant.idApplyCoupon, Constant.idMoneyOffer]);

      final queryParameters = {
        "customerId": customerId,
        "type": type,
        if (type == "2") "amount": amount,
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
      update([Constant.idGetCoupon, Constant.idApplyCoupon, Constant.idMoneyOffer]);
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
