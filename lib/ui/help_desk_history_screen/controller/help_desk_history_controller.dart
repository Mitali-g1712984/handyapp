import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/help_desk_history_screen/model/get_complain_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HelpDeskHistoryController extends GetxController {
  String? helpDeskDate;
  String? helpDeskTime;
  String? date;
  String? time;
  int startComplain = 1;
  int limitComplain = 20;

  ScrollController complainScrollController = ScrollController();

  @override
  void onInit() async {
    complainScrollController.addListener(onComplainPagination);

    await getComplainApiCall(
      customerId: Constant.storage.read("customerId"),
      start: startComplain.toString(),
      limit: limitComplain.toString(),
    );
    super.onInit();
  }

  String formatedDate(String? dateString) {
    DateTime parsedDate = DateFormat("d/M/yyyy, H:mm:ss").parse(dateString ?? "");
    String formatedDate = DateFormat("dd-MM-yyyy").format(parsedDate);
    return formatedDate;
  }

  String formatedTime(String? dateString) {
    String date = dateString?.toUpperCase() ?? "";

    DateTime parsedTime = DateFormat("d/M/yyyy, H:mm:ss a").parse(date);
    String formatedTime = DateFormat("hh:mm a").format(parsedTime);
    return formatedTime;
  }

  void onComplainPagination() async {
    if (complainScrollController.hasClients) {
      if (complainScrollController.position.pixels == complainScrollController.position.maxScrollExtent) {
        await getComplainApiCall(
          customerId: Constant.storage.read("customerId"),
          start: startComplain.toString(),
          limit: limitComplain.toString(),
        );
      }
    }
  }

  onRefresh() async {
    getComplain = [];
    startComplain = 1;

    await getComplainApiCall(
      customerId: Constant.storage.read("customerId"),
      start: startComplain.toString(),
      limit: limitComplain.toString(),
    );
  }

  /// =================== API Calling =================== ///

  GetComplainModel? getComplainModel;
  List<GetComplainData> getComplain = [];
  bool isLoading = false;
  bool isLoading1 = false;

  getComplainApiCall({required String customerId, required String start, required String limit}) async {
    try {
      startComplain++;

      isLoading = true;
      isLoading1 = true;
      update([Constant.idGetComplain]);

      final queryParameters = {
        "customerId": customerId,
        "start": start,
        "limit": limit,
      };

      log("Get Complain Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getComplain + queryString);
      log("Get Complain Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Complain Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Complain Status Code :: ${response.statusCode}");
      log("Get Complain Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getComplainModel = GetComplainModel.fromJson(jsonResponse);

        if (getComplainModel != null) {
          final List<GetComplainData> data = getComplainModel?.data ?? [];

          if (data.isNotEmpty) {
            getComplain.addAll(data);
          }
        }
      }

      log("Get Complain Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Complain Api :: $e");
    } finally {
      isLoading = false;
      isLoading1 = false;
      update([Constant.idGetComplain]);
    }
  }
}
