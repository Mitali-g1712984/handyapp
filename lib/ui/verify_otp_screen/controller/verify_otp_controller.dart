import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/main_screen/controller/main_screen_controller.dart';
import 'package:handy/ui/mobile_number_screen/controller/mobile_number_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';

class VerifyOtpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  dynamic args = Get.arguments;

  Timer? timer;
  String? mobileNumber;
  String? dialCode;
  bool isLoading = false;

  TextEditingController otpController = TextEditingController();
  MobileNumberController mobileNumberController = Get.find<MobileNumberController>();
  MainScreenController mainScreenController = Get.find<MainScreenController>();
  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();

  @override
  void onInit() async {
    await getDataFromArgs();
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null) {
        mobileNumber = args[0];
        dialCode = args[1];
      }

      log("Mobile Number :: $mobileNumber");
      log("Selected Country Code :: $dialCode");
    }
  }

  onResendOtpClick(BuildContext context) async {
    Utils.currentFocus(context);
    Utils.showToast(Get.context!, "Please check your SMS box");
    Constant.storage.write("isResendOtp", true);

    otpController.clear();
    mobileNumberController.verifyPhone();
  }

  onVerifyClick(BuildContext context) async {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate()) {
      await verifyOTP(mobileNumber: mobileNumber ?? "");

      try {
        isLoading = true;
        update([Constant.idLoginOrSignUp]);

        await mainScreenController.loginOrSignUpApiCall(
          name: "",
          email: "",
          password: "",
          mobileNumber: mobileNumber ?? "",
          loginType: 1,
          fcmToken: fcmToken ?? "",
          latitude: latitude.toString(),
          longitude: longitude.toString(),
        );

        if (mainScreenController.loginOrSignUpModel?.status == true) {
          Constant.storage.write("customerId", mainScreenController.loginOrSignUpModel?.customer?.id);
          Utils.showToast(Get.context!, mainScreenController.loginOrSignUpModel?.message ?? "");

          if (mainScreenController.loginOrSignUpModel?.signUp == true) {
            Utils.showToast(Get.context!, mainScreenController.loginOrSignUpModel?.message ?? "");

            Constant.storage.write("isMobileLogin", true);
            Constant.storage.write("isSignUp", true);
            Constant.storage.write("isUpdate", false);
            Constant.storage.write("mobileNumber", mainScreenController.loginOrSignUpModel?.customer?.mobileNumber);
            Constant.storage.write("customerId", mainScreenController.loginOrSignUpModel?.customer?.id);

            Get.toNamed(AppRoutes.editProfile, arguments: [
              mainScreenController.loginOrSignUpModel?.customer?.name,
              mainScreenController.loginOrSignUpModel?.customer?.email,
              mainScreenController.loginOrSignUpModel?.customer?.mobileNumber,
              mainScreenController.loginOrSignUpModel?.customer?.country,
              mainScreenController.loginOrSignUpModel?.customer?.gender,
            ]);
          } else {
            Constant.storage.write("isLogIn", true);
            Constant.storage.write("customerId", mainScreenController.loginOrSignUpModel?.customer?.id);

            try {
              isLoading = true;
              update([Constant.idLoginOrSignUp]);

              await profileScreenController.getCustomerProfileApiCall();

              if (profileScreenController.getCustomerProfileModel?.status == true) {
                Constant.storage.write("customerId", profileScreenController.getCustomerProfileModel?.customer?.id);
                Constant.storage.write("customerName", profileScreenController.getCustomerProfileModel?.customer?.name);
                Constant.storage.write("customerEmail", profileScreenController.getCustomerProfileModel?.customer?.email);
                Constant.storage.write("customerImage", profileScreenController.getCustomerProfileModel?.customer?.profileImage);
                Constant.storage.write("mobileNumber", profileScreenController.getCustomerProfileModel?.customer?.mobileNumber);

                Get.offAllNamed(AppRoutes.bottom);
              } else {
                Utils.showToast(Get.context!, profileScreenController.getCustomerProfileModel?.message ?? "");
              }
            } catch (e) {
              log("Error in Registration Profile :: $e");
            } finally {
              isLoading = false;
              update([Constant.idLoginOrSignUp]);
            }
          }
        } else {
          Utils.showToast(Get.context!, mainScreenController.loginOrSignUpModel?.message ?? "");
        }
      } catch (e) {
        log("Error in Registration Profile ::: $e");
      } finally {
        isLoading = false;
        update([Constant.idLoginOrSignUp]);
      }
    }
  }

  verifyOTP({required String mobileNumber}) async {
    try {
      isLoading = true;
      update([Constant.idLoginOrSignUp]);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: mobileNumberController.verificationCode,
        smsCode: otpController.text,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      log("User Credential :: $userCredential");
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'invalid-verification-code':
          errorMessage = "Invalid verification code. Please check and enter the correct verification code again.";
          break;
        case 'invalid-verification-id':
          errorMessage = "Invalid verification ID.";
          break;
        case 'session-expired':
          errorMessage = "Verification session has expired. Please try again.";
          break;
        case 'quota-exceeded':
          errorMessage = "SMS quota exceeded. Please try again later.";
          break;
        case 'missing-verification-code':
          errorMessage = "Verification code is missing.";
          break;
        case 'missing-verification-id':
          errorMessage = "Verification ID is missing.";
          break;
        case 'app-not-authorized':
          errorMessage = "App is not authorized to use Firebase Authentication.";
          break;
        case 'operation-not-allowed':
          errorMessage = "Phone authentication is not enabled.";
          break;
        case 'too-many-requests':
          errorMessage = "Too many requests. Please try again later.";
          break;
        case 'credential-already-in-use':
          errorMessage = "The phone number is already linked to another account.";
          break;
        default:
          errorMessage = "An error occurred during OTP verification.";
      }

      Utils.showToast(Get.context!, errorMessage);
      log("Verify OTP Code :: ${e.code}");
      log("Verify OTP Message ::  ${e.message}");
      throw Exception("Error occurred during OTP verification");
    } finally {
      isLoading = false;
      update([Constant.idLoginOrSignUp]);
    }
  }
}
