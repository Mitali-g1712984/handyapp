// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:handy/routes/app_routes.dart';
// import 'package:handy/services/app_exception/app_exception.dart';
// import 'package:handy/ui/login_screen/model/check_customer_model.dart';
// import 'package:handy/ui/main_screen/controller/main_screen_controller.dart';
// import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
// import 'package:handy/utils/api.dart';
// import 'package:handy/utils/constant.dart';
// import 'package:handy/utils/global_variables.dart';
// import 'package:handy/utils/utils.dart';
// import 'package:http/http.dart' as http;

// class LoginScreenController extends GetxController {
//   final formKey = GlobalKey<FormState>();
//   bool isObscure = false;

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();
//   MainScreenController mainScreenController = Get.find<MainScreenController>();

//   onClickObscure() {
//     log("isObscure :: $isObscure");
//     isObscure = !isObscure;
//     update();
//   }

//   bool isEmailValid(String email) {
//     final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
//     return emailRegex.hasMatch(email);
//   }

//   onLogInClick(BuildContext context) async {
//     Utils.currentFocus(context);

//     if (formKey.currentState!.validate()) {
//       await checkCustomerApiCall(
//         email: emailController.text,
//         password: passwordController.text,
//         loginType: 3,
//       );

//       if (checkCustomerModel?.status == true) {
//         try {
//           isLoading = true;
//           update([Constant.idCheckCustomer]);

//           await mainScreenController.loginOrSignUpApiCall(
//             name: "",
//             email: emailController.text,
//             password: passwordController.text,
//             mobileNumber: "",
//             loginType: 3,
//             fcmToken: fcmToken ?? "",
//             latitude: latitude.toString(),
//             longitude: longitude.toString(),
//           );

//           if (mainScreenController.loginOrSignUpModel?.status == true) {
//             Constant.storage.write("customerId", mainScreenController.loginOrSignUpModel?.customer?.id);
//             Constant.storage.write("customerName", mainScreenController.loginOrSignUpModel?.customer?.name);
//             Constant.storage.write("customerEmail", mainScreenController.loginOrSignUpModel?.customer?.email);
//             Constant.storage.write("customerImage", mainScreenController.loginOrSignUpModel?.customer?.profileImage);
//             Constant.storage.write("mobileNumber", mainScreenController.loginOrSignUpModel?.customer?.mobileNumber);

//             await profileScreenController.getCustomerProfileApiCall();

//             if (profileScreenController.getCustomerProfileModel?.status == true) {
//               Utils.showToast(Get.context!, checkCustomerModel?.message ?? "");

//               Constant.storage.write("isLogIn", true);
//               Constant.storage.write("customerId", profileScreenController.getCustomerProfileModel?.customer?.id);
//               Constant.storage.write("customerName", profileScreenController.getCustomerProfileModel?.customer?.name);
//               Constant.storage.write("customerEmail", profileScreenController.getCustomerProfileModel?.customer?.email);
//               Constant.storage.write("customerImage", profileScreenController.getCustomerProfileModel?.customer?.profileImage);
//               Constant.storage.write("mobileNumber", profileScreenController.getCustomerProfileModel?.customer?.mobileNumber);

//               Get.offAllNamed(AppRoutes.bottom);
//             }
//           }
//         } catch (e) {
//           log("Error call get profile in Login Api :: $e");
//         } finally {
//           isLoading = false;
//           update([Constant.idCheckCustomer]);
//         }
//       } else {
//         Utils.showToast(Get.context!, profileScreenController.getCustomerProfileModel?.message ?? "");
//       }
//     } else {
//       Utils.showToast(Get.context!, checkCustomerModel?.message ?? "");
//     }
//   }

//   /// =================== API Calling =================== ///

//   CheckCustomerModel? checkCustomerModel;
//   bool isLoading = false;

//   checkCustomerApiCall({
//     required String email,
//     required String password,
//     required int loginType,
//   }) async {
//     try {
//       isLoading = true;
//       update([Constant.idCheckCustomer]);

//       final body = json.encode({
//         "email": email,
//         "password": password,
//         "loginType": loginType,
//       });

//       log("Check Customer Body :: $body");

//       final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.checkCustomer);
//       log("Check Customer Url :: $url");

//       final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
//       log("Check Customer Headers :: $headers");

//       final response = await http.post(url, headers: headers, body: body);

//       log("Check Customer Status Code :: ${response.statusCode}");
//       log("Check Customer Response :: ${response.body}");

//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         checkCustomerModel = CheckCustomerModel.fromJson(jsonResponse);
//       }
//       log("Check Customer Api Called Successfully");
//     } on AppException catch (exception) {
//       Utils.showToast(Get.context!, exception.message);
//     } catch (e) {
//       log("Error call Check Customer Api :: $e");
//       Utils.showToast(Get.context!, '$e');
//     } finally {
//       isLoading = false;
//       update([Constant.idCheckCustomer]);
//     }
//   }
// }


import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';

class LoginScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  bool isObscure = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  onClickObscure() {
    log("isObscure :: $isObscure");
    isObscure = !isObscure;
    update();
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  onLogInClick(BuildContext context) {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate()) {
      // For testing: directly navigate to home screen
      log("Login button clicked, navigating to HomeScreen...");
      Get.offAllNamed(AppRoutes.home);
    } else {
      log("Form is invalid");
    }
  }
}
