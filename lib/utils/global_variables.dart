import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:geolocator/geolocator.dart';

/// ---------- FCMToken Variable ---------- ///
String? fcmToken;

/// ---------- Country Variable ---------- ///
String? country;
String? countryCode;
String? dialCode;

/// ---------- Get Dial Code ---------- ///
getDialCode() {
  CountryCode getCountryDialCode(String countryCode) {
    return CountryCode.fromCountryCode(countryCode);
  }

  CountryCode country = getCountryDialCode(countryCode ?? "IN");
  log("country.Dial code :: ${country.dialCode}");

  dialCode = country.dialCode;
  log("Dial code :: $dialCode");
}

/// ---------- Wallet Variable ---------- ///
num? walletAmount;

/// ---------- Zego engine Variable ---------- ///
String? zegoAppId;
String? zegoAppSignIn;

/// ---------- Payment Variable ---------- ///
String? stripeSecretKey;
String? stripePublishKey;
String? razorpayId;
String? flutterWaveKey;
bool? isRazorPay;
bool? isStripePay;
bool? isFlutterWave;

/// ---------- Currency Variable ---------- ///
String? currency;
String? currencyName;

/// ---------- T&C Variable ---------- ///
String? termsCondition;
String? privacyPolicy;

/// ---------- Location Variable ---------- ///
double? latitude;
double? longitude;
LocationPermission? permission;
Position? position;
