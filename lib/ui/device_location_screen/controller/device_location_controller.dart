import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:handy/custom/dialog/app_maintenance_dialog.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/history_screen/controller/history_screen_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/ui/splash_screen/model/get_country_model.dart';
import 'package:handy/ui/splash_screen/model/get_setting_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceLocationController extends GetxController {
  String fullAddress = "Not Available";
  String city = "Not Available";
  bool isLoading = false;
  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();
  HistoryScreenController historyScreenController = Get.find<HistoryScreenController>();

  /// **Function to check location services & request permission**
  Future<void> checkPermissionAndGetLocation() async {
    try {
      isLoading = true;
      update([Constant.idGetCurrentLocation]);

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log("Location services are disabled. Asking user to enable...");
        // await Geolocator.requestPermission(); // Open location settings
        await Permission.locationAlways.request();
        await getCurrentLocation();
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        await Permission.locationAlways.request();
        await getCurrentLocation();
        if (permission == LocationPermission.denied) {
          log("Location permission denied");
          return;
        }
      }

      // Now fetch location since permission is granted
      await getCurrentLocation();
    } catch (e) {
      log("Error checking location permission: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetCurrentLocation]);
    }
  }

  /// **Function to fetch current location and get address**
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      log("Location fetched: Lat: ${position.latitude}, Lng: ${position.longitude}");

      /// **Convert lat/lng to a full address**
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        fullAddress =
            "${place.street}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
        city = place.locality ?? "Unknown";

        log("Full Address: $fullAddress");
        log("City: $city");

        Constant.storage.write("userAddress", fullAddress);
        Constant.storage.write("currentCity", city);

        onApiCall();
      } else {
        log("No address found.");
      }
    } catch (e) {
      log("Error fetching location: $e");
    }
  }

  onApiCall() async {
    await onGetCountryApiCall();
    getDialCode();
    await onGeSettingApiCall();

    if (getSettingModel?.status == true) {
      zegoAppId = getSettingModel?.data?.zegoAppId;
      zegoAppSignIn = getSettingModel?.data?.zegoAppSignIn;
      stripeSecretKey = getSettingModel?.data?.stripeSecretKey;
      stripePublishKey = getSettingModel?.data?.stripePublishableKey;
      razorpayId = getSettingModel?.data?.razorPayId;
      flutterWaveKey = getSettingModel?.data?.flutterWaveKey;
      currency = getSettingModel?.data?.currency?.symbol;
      currencyName = getSettingModel?.data?.currency?.name;
      isRazorPay = getSettingModel?.data?.isRazorPay;
      isStripePay = getSettingModel?.data?.isStripe;
      isFlutterWave = getSettingModel?.data?.isFlutterWave;
      termsCondition = getSettingModel?.data?.termsOfUsePolicyLink;
      privacyPolicy = getSettingModel?.data?.privacyPolicyLink;

      log("Zego App Id :: $zegoAppId");
      log("Zego App SignIn :: $zegoAppSignIn");
      log("Stripe Secret Key :: $stripeSecretKey");
      log("Stripe Publish Key :: $stripePublishKey");
      log("Razorpay Id :: $razorpayId");
      log("Flutter Wave Key :: $flutterWaveKey");
      log("Currency :: $currency");
      log("Currency Name :: $currencyName");
      log("Is Razor Pay :: $isRazorPay");
      log("Is Stripe Pay :: $isStripePay");
      log("Is Flutter Wave :: $isFlutterWave");
      log("Terms & Condition :: $termsCondition");
      log("Privacy Policy :: $privacyPolicy");

      if (getSettingModel?.data?.isUnderMaintenance == true) {
        Get.dialog(
          barrierColor: AppColors.black.withOpacity(0.8),
          barrierDismissible: false,
          Dialog(
            backgroundColor: AppColors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            child: const AppMaintenanceDialog(),
          ),
        );
      } else {
        profileScreenController.getCustomerProfileApiCall();

        if (profileScreenController.getCustomerProfileModel?.status == true) {
          Constant.storage.write("customerId", profileScreenController.getCustomerProfileModel?.customer?.id);
          Constant.storage.write("customerName", profileScreenController.getCustomerProfileModel?.customer?.name);
          Constant.storage.write("customerEmail", profileScreenController.getCustomerProfileModel?.customer?.email);
          Constant.storage.write("customerImage", profileScreenController.getCustomerProfileModel?.customer?.profileImage);
          Constant.storage.write("mobileNumber", profileScreenController.getCustomerProfileModel?.customer?.mobileNumber);

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

          Constant.storage.write("walletAmount", historyScreenController.getWalletHistoryModel?.total?.toStringAsFixed(2));
          log("Wallet Amount :: ${Constant.storage.read("walletAmount")}");
        }

        Future.delayed(const Duration(seconds: 3), () async {
          if (Constant.storage.read("isUpdate") == false) {
            Get.toNamed(AppRoutes.editProfile, arguments: [
              profileScreenController.getCustomerProfileModel?.customer?.name,
              profileScreenController.getCustomerProfileModel?.customer?.email,
              profileScreenController.getCustomerProfileModel?.customer?.mobileNumber,
              profileScreenController.getCustomerProfileModel?.customer?.country,
              profileScreenController.getCustomerProfileModel?.customer?.gender,
            ]);
          } else {
            if (Constant.storage.read("isOnBoarding") == true) {
              if (Constant.storage.read("isLogIn") == true) {
                Get.offAllNamed(AppRoutes.bottom);
              } else {
                Get.offAllNamed(AppRoutes.main);
              }
            } else {
              Get.offAllNamed(AppRoutes.onBoarding);
            }
          }
        });
      }
    } else {
      Utils.showToast(Get.context!, getSettingModel?.message ?? "");
    }
  }

  /// =================== Get Country API Calling =================== ///
  GetCountryModel? getCountryModel;
  GetSettingModel? getSettingModel;

  onGetCountryApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetCountry, Constant.idGetCurrentLocation]);

      final url = Uri.parse("http://ip-api.com/json");
      final headers = {'Content-Type': 'application/json'};

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getCountryModel = GetCountryModel.fromJson(jsonResponse);
        country = getCountryModel?.country;
        countryCode = getCountryModel?.countryCode;
        log("The Country Name :: $country");
        log("The Country Code :: $countryCode");
      }
    } catch (e) {
      log("Error call Get Country Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetCountry, Constant.idGetCurrentLocation]);
    }
  }

  onGeSettingApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetSetting, Constant.idGetCurrentLocation]);

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getSetting);
      log("Get Setting Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Setting Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Setting Status Code :: ${response.statusCode}");
      log("Get Setting Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getSettingModel = GetSettingModel.fromJson(jsonResponse);
      }

      log("Get Setting Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Setting Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetSetting, Constant.idGetCurrentLocation]);
    }
  }
}
