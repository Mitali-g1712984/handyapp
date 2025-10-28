import 'dart:convert';
import 'dart:developer';

import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/notification_screen/model/clear_all_notification_model.dart';
import 'package:handy/ui/notification_screen/model/get_notification_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class NotificationController extends GetxController {
  String? time;

  @override
  void onInit() async {
    await onGetNotificationApiCall();
    super.onInit();
  }

  onClickClearNotification() async {
    await clearAllNotificationApiCall();

    if (clearAllNotificationModel?.status == true) {
      await onGetNotificationApiCall();
      Utils.showToast(Get.context!, clearAllNotificationModel?.message ?? "");
    } else {
      Utils.showToast(Get.context!, clearAllNotificationModel?.message ?? "");
    }
  }

  /// =================== API Calling =================== ///

  GetNotificationModel? getNotificationModel;
  ClearAllNotificationModel? clearAllNotificationModel;
  bool isLoading = false;

  onGetNotificationApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetNotification, Constant.idClearAllNotification]);

      final queryParameters = {
        "customerId": Constant.storage.read("customerId"),
      };

      log("Get Notification Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getNotification + queryString);
      log("Get Notification Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Notification Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Notification Status Code :: ${response.statusCode}");
      log("Get Notification Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getNotificationModel = GetNotificationModel.fromJson(jsonResponse);
      }

      log("Get Notification Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Notification Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetNotification, Constant.idClearAllNotification]);
    }
  }

  clearAllNotificationApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetNotification, Constant.idClearAllNotification]);

      final queryParameters = {
        "customerId": Constant.storage.read("customerId"),
      };

      log("Clear All Notification Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.clearAllNotification + queryString);
      log("Clear All Notification Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Clear All Notification Headers :: $headers");

      final response = await http.delete(url, headers: headers);

      log("Clear All Notification Status Code :: ${response.statusCode}");
      log("Clear All Notification Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        clearAllNotificationModel = ClearAllNotificationModel.fromJson(jsonResponse);
      }

      log("Clear All Notification Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Clear All Notification Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetNotification, Constant.idClearAllNotification]);
    }
  }
}
