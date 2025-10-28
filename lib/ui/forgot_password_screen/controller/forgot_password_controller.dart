import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/forgot_password_screen/model/generate_otp_for_password_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  onVerifyClick(BuildContext context) async {
    Utils.currentFocus(context);

    Constant.storage.write("isForgotPassword", true);

    if (formKey.currentState!.validate()) {
      await generateOtpForPasswordApiCall(email: emailController.text);

      if (generateOtpForPasswordModel?.status == true) {
        Utils.showToast(Get.context!, generateOtpForPasswordModel?.message ?? "");

        Get.toNamed(
          AppRoutes.verifyPassword,
          arguments: [
            "",
            emailController.text,
            "",
          ],
        );
      } else {
        Utils.showToast(Get.context!, generateOtpForPasswordModel?.message ?? "");
      }
    }
  }

  /// =================== API Calling =================== ///

  GenerateOtpForPasswordModel? generateOtpForPasswordModel;
  bool isLoading = false;

  generateOtpForPasswordApiCall({required String email}) async {
    try {
      isLoading = true;
      update([Constant.idGenerateOtpForPassword]);

      final body = json.encode({
        "email": email,
      });

      log("Generate Otp For Password Body :: $body");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.generateOtpForPassword);
      log("Generate Otp For Password Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Generate Otp For Password Headers :: $headers");

      final response = await http.post(url, headers: headers, body: body);

      log("Generate Otp For Password Status Code :: ${response.statusCode}");
      log("Generate Otp For Password Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        generateOtpForPasswordModel = GenerateOtpForPasswordModel.fromJson(jsonResponse);
      }
      log("Generate Otp For Password Api Called Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Generate Otp For Password Api :: $e");
      Utils.showToast(Get.context!, '$e');
    } finally {
      isLoading = false;
      update([Constant.idGenerateOtpForPassword]);
    }
  }
}
