import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/appointment_screen/model/cancel_appointment_model.dart';
import 'package:handy/ui/appointment_screen/model/get_all_appointment_model.dart';
import 'package:handy/ui/appointment_screen/model/post_review_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:get/get.dart';
import 'package:handy/utils/enums.dart';
import 'package:http/http.dart' as http;
import 'package:handy/utils/utils.dart';

class AppointmentScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController? tabController;
  bool isTabBarApiCalling = false;

  int selectedStarIndex = -1;

  int startPending = 1;
  int limitPending = 20;
  int startCancel = 1;
  int limitCancel = 20;
  int startCompleted = 1;
  int limitCompleted = 20;

  ScrollController pendingScrollController = ScrollController();
  ScrollController cancelScrollController = ScrollController();
  ScrollController completeScrollController = ScrollController();

  TextEditingController reasonController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  @override
  void onInit() async {
    pendingScrollController.addListener(onPendingPagination);
    cancelScrollController.addListener(onCancelPagination);
    completeScrollController.addListener(onCompletePagination);

    tabBarLength();

    await getAllAppointmentApiCall(
      customerId: Constant.storage.read("customerId"),
      status: "1",
      start: startPending.toString(),
      limit: limitPending.toString(),
      startDate: 'All',
      endDate: 'All',
    );

    if (getAllAppointmentModel?.status == true) {
      onTabBarApiCall();
    }
    super.onInit();
  }

  void tabBarLength() {
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    update([Constant.idGetAllAppointment]);
  }

  onSelectedStar(int index) {
    selectedStarIndex = index;
    update([Constant.idSelectStar]);
  }

  onTabBarApiCall() {
    tabController?.addListener(() async {
      isTabBarApiCalling = true;

      await 400.milliseconds.delay();

      if (isTabBarApiCalling) {
        isTabBarApiCalling = false;

        if (tabController?.index == 0) {
          getPending = [];
          startPending = 1;

          await getAllAppointmentApiCall(
            customerId: Constant.storage.read("customerId"),
            status: "1",
            start: startPending.toString(),
            limit: limitPending.toString(),
            startDate: 'All',
            endDate: 'All',
          );
        }

        if (tabController?.index == 1) {
          getCancel = [];
          startCancel = 1;

          await getAllAppointmentApiCall(
            customerId: Constant.storage.read("customerId"),
            status: "4",
            start: startCancel.toString(),
            limit: limitCancel.toString(),
            startDate: 'All',
            endDate: 'All',
          );
        }

        if (tabController?.index == 2) {
          getComplete = [];
          startCompleted = 1;

          await getAllAppointmentApiCall(
            customerId: Constant.storage.read("customerId"),
            status: "3",
            start: startCompleted.toString(),
            limit: limitCompleted.toString(),
            startDate: 'All',
            endDate: 'All',
          );
        }
      }
    });
  }

  void onPendingPagination() async {
    if (pendingScrollController.hasClients) {
      if (pendingScrollController.position.pixels == pendingScrollController.position.maxScrollExtent) {
        await getAllAppointmentApiCall(
          customerId: Constant.storage.read("customerId"),
          status: "1",
          start: startPending.toString(),
          limit: limitPending.toString(),
          startDate: 'All',
          endDate: 'All',
        );
      }
    }
  }

  void onCancelPagination() async {
    if (cancelScrollController.hasClients) {
      if (cancelScrollController.position.pixels == cancelScrollController.position.maxScrollExtent) {
        await getAllAppointmentApiCall(
          customerId: Constant.storage.read("customerId"),
          status: "4",
          start: startCancel.toString(),
          limit: limitCancel.toString(),
          startDate: 'All',
          endDate: 'All',
        );
      }
    }
  }

  void onCompletePagination() async {
    if (completeScrollController.hasClients) {
      if (completeScrollController.position.pixels == completeScrollController.position.maxScrollExtent) {
        await getAllAppointmentApiCall(
          customerId: Constant.storage.read("customerId"),
          status: "3",
          start: startCompleted.toString(),
          limit: limitCompleted.toString(),
          startDate: 'All',
          endDate: 'All',
        );
      }
    }
  }

  onPendingRefresh() async {
    getPending = [];
    startPending = 1;

    await getAllAppointmentApiCall(
      customerId: Constant.storage.read("customerId"),
      status: "1",
      start: startPending.toString(),
      limit: limitPending.toString(),
      startDate: 'All',
      endDate: 'All',
    );
  }

  onCancelRefresh() async {
    getCancel = [];
    startCancel = 1;

    await getAllAppointmentApiCall(
      customerId: Constant.storage.read("customerId"),
      status: "4",
      start: startCancel.toString(),
      limit: limitCancel.toString(),
      startDate: 'All',
      endDate: 'All',
    );
  }

  onCompleteRefresh() async {
    getComplete = [];
    startCompleted = 1;

    await getAllAppointmentApiCall(
      customerId: Constant.storage.read("customerId"),
      status: "3",
      start: startCompleted.toString(),
      limit: limitCompleted.toString(),
      startDate: 'All',
      endDate: 'All',
    );
  }

  onCancelAppointment({required String appointmentId, required BuildContext context}) async {
    Utils.currentFocus(context);

    if (reasonController.text.isEmpty) {
      Utils.showToast(Get.context!, EnumLocale.desPleaseEnterReason.name.tr);
    } else {
      await cancelAppointmentApiCall(
        customerId: Constant.storage.read('customerId'),
        appointmentId: appointmentId,
        reason: reasonController.text,
      );

      if (cancelAppointmentModel?.status == true) {
        Utils.showToast(Get.context!, cancelAppointmentModel?.message ?? "");
        Get.back();

        onPendingRefresh();
      } else {
        Utils.showToast(Get.context!, cancelAppointmentModel?.message ?? "");
      }
    }
  }

  onSubmitReview({
    required String customerId,
    required String agencyId,
    required String appointmentId,
    required String serviceId,
    required String providerId,
    required BuildContext context,
  }) async {
    Utils.currentFocus(context);

    if (selectedStarIndex == -1 || reviewController.text.isEmpty) {
      Utils.showToast(Get.context!, EnumLocale.desPleaseEnterDetails.name.tr);
    } else {
      await postReviewApiCall(
          customerId: customerId,
          appointmentId: appointmentId,
          agencyId: agencyId,
          serviceId: serviceId,
          providerId: providerId,
          rating: selectedStarIndex + 1,
          review: reviewController.text,
          reviewType: 1);

      if (postReviewModel?.status == true) {
        Utils.showToast(Get.context!, postReviewModel?.message ?? "");
        Get.back();

        onCompleteRefresh();
      } else {
        Utils.showToast(Get.context!, postReviewModel?.message ?? "");
      }
    }
  }

  /// =================== API Calling =================== ///

  GetAllAppointmentModel? getAllAppointmentModel;
  CancelAppointmentModel? cancelAppointmentModel;
  PostReviewModel? postReviewModel;
  List<GetAllAppointmentData> getPending = [];
  List<GetAllAppointmentData> getCancel = [];
  List<GetAllAppointmentData> getComplete = [];
  bool isLoading = false;
  bool isLoading1 = false;
  bool isLoading2 = false;

  getAllAppointmentApiCall({
    required String customerId,
    required String status,
    required String startDate,
    required String endDate,
    required String start,
    required String limit,
  }) async {
    try {
      if (status == "1") {
        startPending++;
      } else if (status == "4") {
        startCancel++;
      } else {
        startCompleted++;
      }

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

        getPending = [];
        startPending = 1;
        getCancel = [];
        startCancel = 1;
        getComplete = [];
        startCompleted = 1;

        if (getAllAppointmentModel != null) {
          final List<GetAllAppointmentData> data = getAllAppointmentModel?.data ?? [];

          if (data.isNotEmpty) {
            if (status == "1") {
              getPending.addAll(data);
            } else if (status == "4") {
              getCancel.addAll(data);
            } else {
              getComplete.addAll(data);
            }
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

  cancelAppointmentApiCall({
    required String customerId,
    required String appointmentId,
    required String reason,
  }) async {
    try {
      isLoading2 = true;
      update([Constant.idCancelAppointment]);

      final queryParameters = {
        "customerId": customerId,
        "appointmentId": appointmentId,
        "reason": reason,
      };

      log("Cancel Appointment Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.cancelAppointment + queryString);
      log("Cancel Appointment Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Cancel Appointment Headers :: $headers");

      final response = await http.patch(url, headers: headers);

      log("Cancel Appointment Status Code :: ${response.statusCode}");
      log("Cancel Appointment Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        cancelAppointmentModel = CancelAppointmentModel.fromJson(jsonResponse);
      }

      log("Cancel Appointment Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Cancel Appointment Api :: $e");
    } finally {
      isLoading2 = false;
      update([Constant.idCancelAppointment]);
    }
  }

  postReviewApiCall({
    required String customerId,
    required String agencyId,
    required String appointmentId,
    required String serviceId,
    required String providerId,
    required String review,
    required int reviewType,
    required int rating,
  }) async {
    try {
      isLoading2 = true;
      update([Constant.idPostReview]);

      final body = json.encode({
        "customerId": customerId,
        "agencyId": agencyId,
        "appointmentId": appointmentId,
        "serviceId": serviceId,
        "providerId": providerId,
        "review": review,
        "reviewType": reviewType,
        "rating": rating,
      });

      log("Post Review Body :: $body");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.postReview);
      log("Post Review Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Post Review Headers :: $headers");

      final response = await http.post(url, headers: headers, body: body);

      log("Post Review Status Code :: ${response.statusCode}");
      log("Post Review Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        postReviewModel = PostReviewModel.fromJson(jsonResponse);
      }
      log("Post Review Api Called Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Post Review Api :: $e");
      Utils.showToast(Get.context!, '$e');
    } finally {
      isLoading2 = false;
      update([Constant.idPostReview]);
    }
  }
}
