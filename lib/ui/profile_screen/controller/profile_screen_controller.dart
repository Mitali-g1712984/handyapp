import 'dart:convert';
import 'dart:developer';

import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/profile_screen/model/delete_customer_profile_model.dart';
import 'package:handy/ui/profile_screen/model/get_customer_profile_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:handy/utils/utils.dart';
import 'package:rate_my_app/rate_my_app.dart';

class ProfileScreenController extends GetxController {
  bool isSwitchOn = true;

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'com.incodes.homeserviceuser',
    appStoreIdentifier: '1491556149',
  );

  @override
  void onInit() {
    Constant.storage.write("notification", true);
    super.onInit();
  }

  onSwitch(value) {
    isSwitchOn = value;
    Constant.storage.write("notification", isSwitchOn);
    update([Constant.idSwitchOn]);
  }

  onClickEditProfile() async {
    await getCustomerProfileApiCall();

    if (getCustomerProfileModel?.status == true) {
      Constant.storage.write("customerId", getCustomerProfileModel?.customer?.id);
      Constant.storage.write("customerName", getCustomerProfileModel?.customer?.name);
      Constant.storage.write("customerEmail", getCustomerProfileModel?.customer?.email);
      Constant.storage.write("customerImage", getCustomerProfileModel?.customer?.profileImage);
      Constant.storage.write("mobileNumber", getCustomerProfileModel?.customer?.mobileNumber);

      Get.toNamed(
        AppRoutes.editProfile,
        arguments: [
          getCustomerProfileModel?.customer?.name,
          getCustomerProfileModel?.customer?.email,
          getCustomerProfileModel?.customer?.mobileNumber,
          getCustomerProfileModel?.customer?.country,
          getCustomerProfileModel?.customer?.gender,
        ],
      );
    } else {
      Utils.showToast(Get.context!, getCustomerProfileModel?.message ?? "");
    }
  }

  onDeleteAccountClick() async {
    await deleteCustomerProfileApiCall();

    if (deleteCustomerProfileModel?.status == true) {
      Utils.showToast(Get.context!, deleteCustomerProfileModel?.message ?? "");
      Constant.storage.erase();

      Get.offAllNamed(AppRoutes.onBoarding);
    } else {
      Utils.showToast(Get.context!, deleteCustomerProfileModel?.message ?? "");
      Get.back();
    }
  }

  /// =================== API Calling =================== ///

  GetCustomerProfileModel? getCustomerProfileModel;
  DeleteCustomerProfileModel? deleteCustomerProfileModel;
  bool isLoading = false;

  getCustomerProfileApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetCustomerProfile]);

      final queryParameters = {
        "customerId": Constant.storage.read("customerId") ?? "",
      };

      log("Get Customer Profile Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getCustomerProfile + queryString);
      log("Get Customer Profile Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Customer Profile Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Customer Profile Status Code :: ${response.statusCode}");
      log("Get Customer Profile Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getCustomerProfileModel = GetCustomerProfileModel.fromJson(jsonResponse);
      }

      log("Get Customer Profile Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Customer Profile Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetCustomerProfile]);
    }
  }

  deleteCustomerProfileApiCall() async {
    try {
      isLoading = true;
      update([Constant.idDeleteCustomerProfile]);

      final queryParameters = {
        "customerId": Constant.storage.read("customerId"),
      };

      log("Delete Customer Profile Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.deleteCustomerProfile + queryString);
      log("Delete Customer Profile Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Delete Customer Profile Headers :: $headers");

      final response = await http.delete(url, headers: headers);

      log("Delete Customer Profile Status Code :: ${response.statusCode}");
      log("Delete Customer Profile Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        deleteCustomerProfileModel = DeleteCustomerProfileModel.fromJson(jsonResponse);
      }

      log("Delete Customer Profile Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Delete Customer Profile Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idDeleteCustomerProfile]);
    }
  }
}
