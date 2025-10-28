import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/booking_screen/model/get_appointment_time_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class BookingScreenController extends GetxController {
  dynamic args = Get.arguments;
  final formKey = GlobalKey<FormState>();

  String? formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime selectedDate = DateTime.now();

  String? slotsString;
  List<String> morningSlots = [];
  List<String> afternoonSlots = [];
  List<String> selectedSlotsList = [];
  String? serviceStartTime;
  String? serviceBreakStartTime;
  String? serviceBreakEndTime;
  String? serviceEndTime;
  bool isFirstTap = false;
  bool hasMorningSlots = true;

  num? basePrice;
  num? taxAmount;
  num? addOnPrice;
  num? totalServicePrice;
  num? finalAmount;

  Color? color;
  Color? textColor;
  String? providerId;
  String? profileImage;
  String? name;
  String? services;
  String? price;
  String? avgRating;
  String? serviceId;
  num? taxRate;
  List<String>? selectedAddOnServiceIds;
  String? selectedAddOnServicePrices;
  String? matchingPackageId;
  num? matchingPackagePrice;

  List<num> priceList = [];

  /// for Select Multiple image
  final ImagePicker imagePicker = ImagePicker();
  List<File>? imageFileList = [];
  List<XFile>? selectedImages = [];

  TextEditingController serviceController = TextEditingController();

  @override
  void onInit() async {
    await getDataFromArgs();

    // Parse base price and ensure it's not null or empty
    basePrice = price != null && price!.isNotEmpty ? num.parse(price!) : 0;
    addOnPrice = 0; // Default to 0 if no add-ons

    // Process add-on prices when multiple values exist
    if (selectedAddOnServiceIds?.isNotEmpty == true) {
      if (selectedAddOnServicePrices != null && selectedAddOnServicePrices!.isNotEmpty) {
        // Convert multiple prices to a sum and store in addOnPrice
        addOnPrice = selectedAddOnServicePrices!
            .split(',') // Split into a list of strings
            .map((e) => num.tryParse(e) ?? 0) // Convert to numbers safely
            .fold(0, (sum, price) => (sum!) + price); // Sum all values
      }
    }

    // Determine the base for tax calculation
    if (matchingPackagePrice != null && matchingPackagePrice! > 0) {
      totalServicePrice = matchingPackagePrice!;
    } else if ((selectedAddOnServiceIds?.isEmpty == true) &&
        (matchingPackagePrice == null || matchingPackagePrice == 0)) {
      totalServicePrice = basePrice!;
    } else {
      totalServicePrice = basePrice! + addOnPrice!;
    }

    // Ensure taxRate is not null
    num effectiveTaxRate = taxRate ?? 0;

    // Calculate tax based on totalServicePrice
    taxAmount = (effectiveTaxRate * totalServicePrice!) / 100;

    // Calculate final amount (Total Service Price + Tax)
    finalAmount = totalServicePrice! + taxAmount!;

    log("Base Price :: $basePrice");
    log("Add-On Price :: $addOnPrice"); // Now correctly stores multiple prices' sum
    log("Matching Package Price :: $matchingPackagePrice");
    log("Tax Rate :: $taxRate");
    log("Total Service Price Before Tax :: $totalServicePrice");
    log("Tax Amount :: $taxAmount");
    log("Final Amount :: $finalAmount");

    onGetTodayTime();

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
          args[13] != null) {
        color = args[0];
        textColor = args[1];
        providerId = args[2];
        profileImage = args[3];
        name = args[4];
        services = args[5];
        price = args[6];
        avgRating = args[7];
        serviceId = args[8];
        taxRate = args[9];
        selectedAddOnServiceIds = args[10];
        selectedAddOnServicePrices = args[11];
        matchingPackageId = args[12];
        matchingPackagePrice = args[13];
      }

      log("Color :: $color");
      log("Text Color :: $textColor");
      log("Provider ID :: $providerId");
      log("Profile Image :: $profileImage");
      log("Name :: $name");
      log("Services :: $services");
      log("Price :: $price");
      log("Avg Rating :: $avgRating");
      log("Service ID booking screen :: $serviceId");
      log("Tax Rate booking screen :: $taxRate");
      log("selectedAddOnServiceIds :: $selectedAddOnServiceIds");
      log("selectedAddOnServicePrices :: $selectedAddOnServicePrices");
      log("matchingPackageId :: $matchingPackageId");
      log("matchingPackagePrice :: $matchingPackagePrice");
    }
  }

  onGetTodayTime() async {
    try {
      isLoading1 = true;
      update([Constant.idGetAppointmentTime]);

      await getAppointmentTimeApiCall(
        agencyId: providerId ?? "",
        date: formattedDate ?? "",
        serviceId: serviceId ?? "",
      );

      onGetSlotsList();
    } catch (e) {
      log("Error in get today time :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idGetAppointmentTime]);
    }
  }

  onMultiplePickImage() async {
    selectedImages = await imagePicker.pickMultiImage();

    if (selectedImages!.isNotEmpty) {
      for (XFile images in selectedImages!) {
        imageFileList!.add(File(images.path));
      }
    }
    update([Constant.idPickImage]);
  }

  onRemoveImage(int index) {
    imageFileList!.removeAt(index);
    update([Constant.idRemoveImage, Constant.idPickImage]);
  }

  /// =================== Select Slot`s =================== ///
  onGetSlotsList() {
    morningSlots.clear();
    afternoonSlots.clear();

    for (var i = 0; i < (getAppointmentTimeModel?.morningSlots?.length ?? 0); i++) {
      morningSlots.add(getAppointmentTimeModel?.morningSlots?[i] ?? "");
    }

    for (var i = 0; i < (getAppointmentTimeModel?.eveningSlots?.length ?? 0); i++) {
      afternoonSlots.add(getAppointmentTimeModel?.eveningSlots?[i] ?? "");
    }

    serviceStartTime = morningSlots.first;
    serviceBreakStartTime = morningSlots.last;

    afternoonSlots = afternoonSlots.sublist(1);
    serviceEndTime = afternoonSlots.last;
    serviceBreakEndTime = afternoonSlots.first;

    log("Morning Slot :: $morningSlots");
    log("Afternoon Slot :: $afternoonSlots");

    update([Constant.idUpdateSlots, Constant.idGetAppointmentTime]);
  }

  void selectSlot(String slot) {
    selectedSlotsList.clear();

    selectedSlotsList.add(slot);
    update([Constant.idUpdateSlots, Constant.idGetAppointmentTime]);
  }

  List<DateTime> getDisabledDates() {
    DateTime currentDate = DateTime.now();
    List<DateTime> disabledDates = [];

    for (int i = 0; i < currentDate.day - 1; i++) {
      disabledDates.add(currentDate.subtract(Duration(days: i + 1)));
    }

    return disabledDates;
  }

  onConfirmBookingClick(BuildContext context) {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate() && selectedSlotsList.isNotEmpty) {
      Get.toNamed(
        AppRoutes.confirmBooking,
        arguments: [
          color,
          textColor,
          providerId,
          profileImage,
          name,
          services,
          price,
          avgRating,
          formattedDate,
          selectedSlotsList.join(),
          serviceController.text,
          imageFileList,
          serviceId,
          taxRate,
          priceList,
          selectedAddOnServiceIds,
          addOnPrice,
          basePrice,
          addOnPrice,
          taxAmount,
          finalAmount,
          totalServicePrice,
          matchingPackageId,
          matchingPackagePrice,
          getAppointmentTimeModel?.timeSlot,
        ],
      );
    } else {
      if (selectedSlotsList.isEmpty) {
        Utils.showToast(Get.context!, EnumLocale.toastSelectTime.name.tr);
      }
    }
  }

  /// =================== API Calling =================== ///

  GetAppointmentTimeModel? getAppointmentTimeModel;
  bool isLoading = false;
  bool isLoading1 = false;

  getAppointmentTimeApiCall(
      {required String agencyId, required String date, required String serviceId}) async {
    try {
      isLoading = true;
      update([Constant.idGetAppointmentTime]);

      final queryParameters = {
        "agencyId": agencyId,
        "serviceId": serviceId,
        "date": date,
      };

      log("Get Appointment Time Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url =
          Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAppointmentTimeModel + queryString);
      log("Get Appointment Time Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Appointment Time Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Appointment Time Status Code :: ${response.statusCode}");
      log("Get Appointment Time Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAppointmentTimeModel = GetAppointmentTimeModel.fromJson(jsonResponse);
      }

      log("Get Appointment Time Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Appointment Time Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetAppointmentTime]);
    }
  }
}
