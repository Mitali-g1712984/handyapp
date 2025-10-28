import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/service_wise_agency_screen/model/get_service_wise_agency_model.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;

class ServiceWiseAgencyController extends GetxController {
  String? serviceName;
  String? serviceId;
  Color? colorList;
  Color? textColorList;
  int? selectServiceColor;
  dynamic args = Get.arguments;
  List<bool> isFavouriteAgency = [];

  List ratings = ["5", "4", "3", "2", "1"];
  String? finalRating;
  int ratingSelect = -1;

  List sortBy = ["Low", "Medium", "High"];
  int selectFeesIndex = -1;
  String? finalFees;
  int? fees;

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  @override
  void onInit() async {
    await getDataFromArgs();

    await getServiceWiseAgencyApiCall(
      customerId: Constant.storage.read('customerId'),
      serviceId: serviceId ?? "",
      rating: finalRating ?? "",
      priceCategory: finalFees ?? "",
      // city: Constant.storage.read("currentCity"),
      city: "surat",
    );

    for (int i = 0; i < (getServiceWiseAgencyModel?.data?.length ?? 0); i++) {
      isFavouriteAgency.add(getServiceWiseAgencyModel?.data?[i].isFavorite ?? false);
    }

    log("Favourite Agency :: $isFavouriteAgency");

    super.onInit();
  }

  onRatingSelect(int index) {
    if (ratingSelect == index) {
      ratingSelect = -1;
      finalRating = "";
    } else {
      ratingSelect = index;
      finalRating = ratings[index];
    }
    log("Ratings :: $finalRating");
    update([Constant.idRatingSelect, Constant.idApplyFilter]);
  }

  onSelectFees(int index) {
    if (selectFeesIndex == index) {
      selectFeesIndex = -1;
      fees = 0;
      finalFees = "";
    } else {
      selectFeesIndex = index;
      fees = selectFeesIndex + 1;
      finalFees = sortBy[index];
    }
    log("Final Fees :: ${finalFees?.toLowerCase()}");
    update([Constant.idSelectSortBy, Constant.idApplyFilter]);
  }

  onFavouriteAgency({required String customerId, required String agencyId}) async {
    await homeScreenController.favouriteAgencyByCustomerApiCall(
      customerId: customerId,
      agencyId: agencyId,
    );

    if (homeScreenController.favoriteAgencyByCustomerModel?.status == true) {
      if (homeScreenController.favoriteAgencyByCustomerModel?.isFavorite == true) {
        Utils.showToast(Get.context!, "Agency favorite successfully");

        int? index = homeScreenController.getTopRatedAgencyModel?.data?.indexWhere((element) => element.id == agencyId);
        if (index != null) {
          isFavouriteAgency[index] = true;
        }
      } else {
        int? index = homeScreenController.getTopRatedAgencyModel?.data?.indexWhere((element) => element.id == agencyId);
        if (index != null) {
          isFavouriteAgency[index] = false;
        }
      }
    } else {
      Utils.showToast(Get.context!, homeScreenController.favoriteAgencyByCustomerModel?.message ?? "");
    }

    update([Constant.idCategoryProviderSaved]);
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null || args[3] != null || args[4] != null) {
        serviceName = args[0];
        serviceId = args[1];
        colorList = args[2];
        textColorList = args[3];
        selectServiceColor = args[4];
      }

      log("Service Name :: $serviceName");
      log("Service Id :: $serviceId");
      log("colorList :: $colorList");
      log("selectServiceColor :: $selectServiceColor");
    }
  }

  onApplyFilter() async {
    try {
      isLoading = true;
      update([Constant.idGetFilterWiseAgency]);

      Get.back();

      await getServiceWiseAgencyApiCall(
        customerId: Constant.storage.read('customerId'),
        serviceId: serviceId ?? "",
        rating: finalRating ?? "",
        priceCategory: finalFees ?? "",
        // city: Constant.storage.read("currentCity"),
        city: "surat",
      );
    } catch (e) {
      log("Error in apply filter :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetFilterWiseAgency]);
    }
  }

  onBackToFilter() async {
    Get.back();

    await getServiceWiseAgencyApiCall(
      customerId: Constant.storage.read('customerId'),
      serviceId: serviceId ?? "",
      rating: finalRating ?? "",
      priceCategory: finalFees ?? "",
      // city: Constant.storage.read("currentCity"),
      city: "surat",
    );
  }

  /// =================== API Calling =================== ///

  GetServiceWiseAgencyModel? getServiceWiseAgencyModel;
  bool isLoading = false;

  getServiceWiseAgencyApiCall({
    required String customerId,
    required String serviceId,
    required String rating,
    required String priceCategory,
    required String city,
  }) async {
    try {
      isLoading = true;
      update([Constant.idGetServiceWiseAgency]);

      final queryParameters = {
        "customerId": customerId,
        "serviceId": serviceId,
        "rating": rating,
        "priceCategory": priceCategory,
        "city": city,
      };

      log("Get Service Wise Agency Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getServiceWiseAgency + queryString);
      log("Get Service Wise Agency Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Service Wise Agency Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Service Wise Agency Status Code :: ${response.statusCode}");
      log("Get Service Wise Agency Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getServiceWiseAgencyModel = GetServiceWiseAgencyModel.fromJson(jsonResponse);
      }

      log("Get Service Wise Agency Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Service Wise Agency Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetServiceWiseAgency]);
    }
  }
}
