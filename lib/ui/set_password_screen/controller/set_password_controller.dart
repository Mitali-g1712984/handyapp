import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/set_password_screen/model/set_password_model.dart';
import 'package:handy/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';

class SetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  dynamic args = Get.arguments;

  String? email;
  bool isObscure = true;
  bool isObscure1 = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  void onInit() async {
    await getDataFromArgs();
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        email = args[0];
      }

      log("Email :: $email");
    }
  }

  onClickObscure() {
    log("isObscure :: $isObscure");
    isObscure = !isObscure;
    update();
  }

  onClickObscure1() {
    log("isObscure :: $isObscure1");
    isObscure1 = !isObscure1;
    update();
  }

  onConfirmButtonClick(BuildContext context) async {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate()) {
      await setPasswordApiCall(
        email: email ?? "",
        newPassword: passwordController.text,
        confirmPassword: rePasswordController.text,
      );

      if (setPasswordModel?.status == true) {
        Utils.showToast(Get.context!, setPasswordModel?.message ?? "");

        Get.close(3);
      } else {
        Utils.showToast(Get.context!, setPasswordModel?.message ?? "");
      }
    }
  }

  /// =================== API Calling =================== ///

  SetPasswordModel? setPasswordModel;
  bool isLoading = false;

  setPasswordApiCall({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      isLoading = true;
      update([Constant.idSetPassword]);

      final body = json.encode({
        "email": email,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      });

      log("Set Password Body :: $body");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.setPassword);
      log("Set Password Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Set Password Headers :: $headers");

      final response = await http.patch(url, headers: headers, body: body);

      log("Set Password Status Code :: ${response.statusCode}");
      log("Set Password Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setPasswordModel = SetPasswordModel.fromJson(jsonResponse);
      }
      log("Set Password Api Called Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Set Password Api :: $e");
      Utils.showToast(Get.context!, '$e');
    } finally {
      isLoading = false;
      update([Constant.idSetPassword]);
    }
  }
}
