import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:http/http.dart' as http;
import 'package:handy/ui/registration_screen/model/generate_otp_for_login_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';

class RegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  bool isObscure = false;
  bool isObscure1 = false;
  bool isCheck = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  onClickObscure() {
    log("isObscure :: $isObscure");
    isObscure = !isObscure;
    update();
  }

  onClickObscure1() {
    log("isObscure :: $isObscure1");
    isObscure1 = !isObscure1;
  }

  onClickCheck() {
    log("isCheck:: $isCheck");
    isCheck = !isCheck;
    update([Constant.idAcceptTerms]);
  }

  onVerifyClick(BuildContext context) async {
    Utils.currentFocus(context);

    Constant.storage.write("isForgotPassword", false);

    if (formKey.currentState!.validate()) {
      if (isCheck) {
        await generateOtpForLoginApiCall(email: emailController.text);

        if (generateOtpForLoginModel?.status == true) {
          Utils.showToast(Get.context!, generateOtpForLoginModel?.message ?? "");

          Get.toNamed(
            AppRoutes.verifyPassword,
            arguments: [
              nameController.text,
              emailController.text,
              rePasswordController.text,
            ],
          );
        } else {
          Utils.showToast(Get.context!, generateOtpForLoginModel?.message ?? "");
        }
      } else {
        Utils.showToast(Get.context!, "Please accept terms and policy first");
      }
    }
  }

  /// =================== API Calling =================== ///

  GenerateOtpForLoginModel? generateOtpForLoginModel;
  bool isLoading = false;

  generateOtpForLoginApiCall({required String email}) async {
    try {
      isLoading = true;
      update([Constant.idGenerateOtpForLogin]);

      final body = json.encode({
        "email": email,
      });

      log("Generate Otp For Login Body :: $body");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.generateOtpForLogin);
      log("Generate Otp For Login Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Generate Otp For Login Headers :: $headers");

      final response = await http.post(url, headers: headers, body: body);

      log("Generate Otp For Login Status Code :: ${response.statusCode}");
      log("Generate Otp For Login Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        generateOtpForLoginModel = GenerateOtpForLoginModel.fromJson(jsonResponse);
      }
      log("Generate Otp For Login Api Called Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Generate Otp For Login Api :: $e");
      Utils.showToast(Get.context!, '$e');
    } finally {
      isLoading = false;
      update([Constant.idGenerateOtpForLogin]);
    }
  }
}
