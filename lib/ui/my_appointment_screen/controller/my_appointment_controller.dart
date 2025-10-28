import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/appointment_screen/model/get_all_appointment_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:handy/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyAppointmentController extends GetxController {
  String selectedDates = '';
  String dateCount = '';
  String range = '';
  String rangeCount = '';
  String? startDateFormatted;
  String? endDateFormatted;

  int startAppointment = 1;
  int limitAppointment = 10;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    scrollController.addListener(onPagination);

    await getAllAppointmentApiCall(
      customerId: Constant.storage.read("customerId"),
      status: 'All',
      start: startAppointment.toString(),
      limit: limitAppointment.toString(),
      startDate: 'All',
      endDate: 'All',
    );
    super.onInit();
  }

  void onPagination() async {
    if (scrollController.hasClients) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        await getAllAppointmentApiCall(
          customerId: Constant.storage.read("customerId"),
          status: 'All',
          start: startAppointment.toString(),
          limit: limitAppointment.toString(),
          startDate: 'All',
          endDate: 'All',
        );
      }
    }
  }

  onRefresh() async {
    getMyAppointment = [];
    startAppointment = 1;

    await getAllAppointmentApiCall(
      customerId: Constant.storage.read("customerId"),
      status: 'All',
      start: startAppointment.toString(),
      limit: limitAppointment.toString(),
      startDate: 'All',
      endDate: 'All',
    );
  }

  onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDateFormatted = DateFormat('yyyy-MM-dd').format(args.value.startDate);
      endDateFormatted = DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate);

      range = '$startDateFormatted - $endDateFormatted';
    } else if (args.value is DateTime) {
      selectedDates = args.value.toString();
    } else if (args.value is List<DateTime>) {
      dateCount = args.value.length.toString();
    } else {
      rangeCount = args.value.length.toString();
    }
    update([Constant.idSelectDateRange]);
  }

  /// =================== API Calling =================== ///

  GetAllAppointmentModel? getAllAppointmentModel;
  List<GetAllAppointmentData> getMyAppointment = [];
  bool isLoading = false;
  bool isLoading1 = false;

  getAllAppointmentApiCall({
    required String customerId,
    required String status,
    required String startDate,
    required String endDate,
    required String start,
    required String limit,
  }) async {
    try {
      startAppointment++;

      isLoading = true;
      isLoading1 = true;
      update([Constant.idGetAllAppointment]);

      final queryParameters = {
        "customerId": customerId,
        "status": status,
        "startDate": startDate,
        "endDate": endDate,
        "start": start,
        "limit": limit,
      };

      log("Get All Appointment Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAllAppointment + queryString);
      log("Get All Appointment Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get All Appointment Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get All Appointment Status Code :: ${response.statusCode}");
      log("Get All Appointment Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAllAppointmentModel = GetAllAppointmentModel.fromJson(jsonResponse);

        if (getAllAppointmentModel != null) {
          final List<GetAllAppointmentData> data = getAllAppointmentModel?.data ?? [];

          if (data.isNotEmpty) {
            getMyAppointment.addAll(data);
          }
        }
      }

      log("Get All Appointment Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get All Appointment Api :: $e");
    } finally {
      isLoading = false;
      isLoading1 = false;
      update([Constant.idGetAllAppointment]);
    }
  }
}
