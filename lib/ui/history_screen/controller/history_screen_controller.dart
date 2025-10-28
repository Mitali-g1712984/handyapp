import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/history_screen/model/get_wallet_history_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HistoryScreenController extends GetxController {
  String selectedMonth = DateFormat('yyyy-MM').format(DateTime.now());

  int startWalletHistory = 1;
  int limitWalletHistory = 20;
  ScrollController scrollController = ScrollController();

  onClickMonth() {
    showMonthPicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),

      monthPickerDialogSettings: MonthPickerDialogSettings(
        actionBarSettings: PickerActionBarSettings(
          confirmWidget: Text(
            "Confirm",
            style: AppFontStyle.fontStyleW600(
              fontSize: 15,
              fontColor: AppColors.primaryAppColor1,
            ),
          ),
          cancelWidget: Text(
            "Cancel",
            style: AppFontStyle.fontStyleW600(
              fontSize: 15,
              fontColor: AppColors.primaryAppColor1,
            ),
          ),
        ),
        dateButtonsSettings: PickerDateButtonsSettings(
          currentMonthTextColor: AppColors.primaryAppColor1,
          unselectedMonthsTextColor: AppColors.primaryAppColor1,
          selectedMonthBackgroundColor: AppColors.primaryAppColor1,
        ),
        headerSettings: PickerHeaderSettings(
          headerBackgroundColor: AppColors.primaryAppColor1,
        ),
        dialogSettings: PickerDialogSettings(
          dialogBackgroundColor: AppColors.white,
          dialogRoundedCornersRadius: 16,
        ),
      ),

    ).then((date) async {
      if (date != null) {
        selectedMonth = DateFormat('yyyy-MM').format(date);

        getWalletHistory = [];
        startWalletHistory = 1;

        await getWalletHistoryApiCall(
          customerId: Constant.storage.read('customerId'),
          month: selectedMonth,
          start: startWalletHistory.toString(),
          limit: limitWalletHistory.toString(),
        );

        log("Selected Month for History :: $selectedMonth");
        update([Constant.idSelectMonth]);
      }
    });
  }

  @override
  void onInit() async {
    scrollController.addListener(onWalletHistoryPagination);

    getWalletHistory = [];
    startWalletHistory = 1;

    await getWalletHistoryApiCall(
      customerId: Constant.storage.read('customerId') ?? "",
      month: selectedMonth,
      start: startWalletHistory.toString(),
      limit: limitWalletHistory.toString(),
    );
    super.onInit();
  }

  void onWalletHistoryPagination() async {
    if (scrollController.hasClients) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        await getWalletHistoryApiCall(
          customerId: Constant.storage.read('customerId'),
          month: selectedMonth,
          start: startWalletHistory.toString(),
          limit: limitWalletHistory.toString(),
        );
      }
    }
  }

  onWalletHistoryRefresh() async {
    getWalletHistory = [];
    startWalletHistory = 1;

    await getWalletHistoryApiCall(
      customerId: Constant.storage.read('customerId'),
      month: selectedMonth,
      start: startWalletHistory.toString(),
      limit: limitWalletHistory.toString(),
    );
  }

  /// =================== API Calling =================== ///

  GetWalletHistoryModel? getWalletHistoryModel;
  List<GetWalletHistoryData> getWalletHistory = [];
  bool isLoading = false;
  bool isLoading1 = false;

  getWalletHistoryApiCall({
    required String customerId,
    required String month,
    required String start,
    required String limit,
  }) async {
    try {
      startWalletHistory++;

      isLoading = true;
      isLoading1 = true;
      update([Constant.idGetWalletHistory]);

      final queryParameters = {
        "customerId": customerId,
        "month": month,
        "start": start,
        "limit": limit,
      };

      log("Get Wallet History Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getWalletHistory + queryString);
      log("Get Wallet History Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Wallet History Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Wallet History Status Code :: ${response.statusCode}");
      log("Get Wallet History Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getWalletHistoryModel = GetWalletHistoryModel.fromJson(jsonResponse);

        getWalletHistory = [];
        startWalletHistory = 1;

        if (getWalletHistoryModel != null) {
          final List<GetWalletHistoryData> data = getWalletHistoryModel?.data ?? [];

          if (data.isNotEmpty) {
            getWalletHistory.addAll(data);
          }
        }
      }

      log("Get Wallet History Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Wallet History Api :: $e");
    } finally {
      isLoading = false;
      isLoading1 = false;
      update([Constant.idGetWalletHistory]);
    }
  }
}
