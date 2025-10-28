import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/forgot_password_screen/controller/forgot_password_controller.dart';
import 'package:handy/ui/main_screen/controller/main_screen_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/ui/verify_password_screen/model/verify_otp_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';

class VerifyPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  dynamic args = Get.arguments;

  String? name;
  String? email;
  String? password;

  TextEditingController otpController = TextEditingController();
  MainScreenController mainScreenController = Get.find<MainScreenController>();
  ForgotPasswordController forgotPasswordController = Get.find<ForgotPasswordController>();
  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();

  @override
  void onInit() {
    getDataFromArgs();
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null) {
        name = args[0];
        email = args[1];
        password = args[2];
      }

      log("Name :: $name");
      log("Email :: $email");
      log("Password :: $password");
    }
  }

  onClickResendOtpForLogin() async {
    otpController.clear();

    try {
      isLoading = true;
      update([Constant.idVerifyOTP]);

      await forgotPasswordController.generateOtpForPasswordApiCall(email: email ?? "");

      if (forgotPasswordController.generateOtpForPasswordModel?.status == true) {
        Utils.showToast(Get.context!, "Please Check your mail box");
      } else {
        Utils.showToast(Get.context!, forgotPasswordController.generateOtpForPasswordModel?.message ?? "");
      }
    } catch (e) {
      log("Error in Generate OTP in verify password Screen");
    } finally {
      isLoading = false;
      update([Constant.idVerifyOTP]);
    }
  }

  onVerifyClickForLogin() async {
    try {
      isLoading = true;
      update([Constant.idVerifyOTP]);

      await mainScreenController.loginOrSignUpApiCall(
        name: name ?? "",
        email: email ?? "",
        password: password ?? "",
        mobileNumber: "",
        loginType: 3,
        fcmToken: fcmToken ?? "",
        latitude: latitude.toString(),
        longitude: longitude.toString(),
      );
      if (mainScreenController.loginOrSignUpModel?.status == true) {
        Utils.showToast(Get.context!, mainScreenController.loginOrSignUpModel?.message ?? "");
        Constant.storage.write("customerId", mainScreenController.loginOrSignUpModel?.customer?.id);

        await profileScreenController.getCustomerProfileApiCall();

        if (profileScreenController.getCustomerProfileModel?.status == true) {
          Constant.storage.write("customerId", profileScreenController.getCustomerProfileModel?.customer?.id);
          Constant.storage.write("customerName", profileScreenController.getCustomerProfileModel?.customer?.name);
          Constant.storage.write("customerEmail", profileScreenController.getCustomerProfileModel?.customer?.email);
          Constant.storage.write("customerImage", profileScreenController.getCustomerProfileModel?.customer?.profileImage);
          Constant.storage.write("mobileNumber", profileScreenController.getCustomerProfileModel?.customer?.mobileNumber);

          Constant.storage.write("isLogIn", true);

          Get.offAllNamed(AppRoutes.bottom);
        } else {
          Utils.showToast(Get.context!, profileScreenController.getCustomerProfileModel?.message ?? "");
        }
      } else {
        Utils.showToast(Get.context!, mainScreenController.loginOrSignUpModel?.message ?? "");
      }
    } catch (e) {
      log("Error in :: $e");
    } finally {
      isLoading = false;
      update([Constant.idVerifyOTP]);
    }
  }

  onVerifyOtp() async {
    await verifyOtpApiCall(
      email: email ?? "",
      otp: int.parse(otpController.text),
    );

    if (verifyOtpModel?.status == true) {
      otpController.clear();

      if (Constant.storage.read("isForgotPassword") == true) {
        Get.toNamed(
          AppRoutes.setPassword,
          arguments: [
            email,
          ],
        );
      } else {
        onVerifyClickForLogin();
      }
    } else {
      Utils.showToast(Get.context!, verifyOtpModel?.message ?? "");
    }
  }

  /// =================== API Calling =================== ///

  VerifyOtpModel? verifyOtpModel;
  bool isLoading = false;

  verifyOtpApiCall({
    required String email,
    required int otp,
  }) async {
    try {
      isLoading = true;
      update([Constant.idVerifyOTP]);

      final body = json.encode({
        "email": email,
        "otp": otp,
      });

      log("Verify Otp Body :: $body");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.verifyOtp);
      log("Verify Otp Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Verify Otp Headers :: $headers");

      final response = await http.post(url, headers: headers, body: body);

      log("Verify Otp Status Code :: ${response.statusCode}");
      log("Verify Otp Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        verifyOtpModel = VerifyOtpModel.fromJson(jsonResponse);
      }
      log("Verify Otp Api Called Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Verify Otp Api :: $e");
      Utils.showToast(Get.context!, '$e');
    } finally {
      isLoading = false;
      update([Constant.idVerifyOTP]);
    }
  }
}
