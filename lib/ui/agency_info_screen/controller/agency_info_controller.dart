import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/agency_info_screen/model/get_agency_info_model.dart';
import 'package:handy/ui/agency_info_screen/model/get_service_specific_add_on_model.dart';
import 'package:handy/ui/provider_list_screen/model/get_agency_wise_provider_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;

class AgencyInfoController extends GetxController with GetSingleTickerProviderStateMixin {
  dynamic args = Get.arguments;
  Color? color;
  Color? textColor;
  String? agencyId;
  String? serviceId;
  String? servicePrice;
  String? mainServicePrice;
  String? serviceName;
  int selectServiceColor = 0;
  int serviceColor = 0;
  int startAgencyWiseProvider = 1;
  int limitAgencyWiseProvider = 20;
  String? selectedServiceId;

  List<String> selectedAddOnServiceIds = [];
  List<String> selectedAddOnServicePrices = [];

  bool isSaved = false;
  late TabController? tabController;

  @override
  void onInit() async {
    tabController = TabController(initialIndex: 0, length: 4, vsync: this);

    await getDataFromArgs();
    await getAgencyInfoApiCall(
      agencyId: agencyId ?? "",
      customerId: Constant.storage.read('customerId'),
    );
    await onGetAgencyWiseProviderApiCall(
      agencyId: agencyId ?? "",
      start: startAgencyWiseProvider.toString(),
      limit: limitAgencyWiseProvider.toString(),
    );

    if (servicePrice?.isNotEmpty == true) {
      await selectService(
        serviceId: serviceId ?? "",
        price: servicePrice ?? "",
        name: serviceName ?? "",
        index: selectServiceColor,
      );
    }

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null ||
          args[1] != null ||
          args[2] != null ||
          args[3] != null ||
          args[4] != null ||
          args[5] != null ||
          args[6] != null) {
        color = args[0];
        textColor = args[1];
        agencyId = args[2];
        serviceId = args[3];
        servicePrice = args[4];
        serviceName = args[5];
        selectServiceColor = args[6];
        serviceColor = args[6];
      }

      log("Color :: $color");
      log("Text Color :: $textColor");
      log("Agency ID :: $agencyId");
      log("Service ID Provider Detail :: $serviceId");
      log("Service Price Provider Detail :: $servicePrice");
      log("Service Name Provider Detail :: $serviceName");
      log("selectServiceColor :: $selectServiceColor");
      log("serviceColor :: $serviceColor");
    }
  }

  selectService({
    required String serviceId,
    required String price,
    required String name,
    required int index,
  }) async {
    if (selectedServiceId == serviceId) {
      selectedServiceId = null;
      getServiceSpecificAddOnModel = null;
      servicePrice = "";
      serviceName = "";
      selectServiceColor = serviceColor;
    } else {
      selectedServiceId = serviceId;
      servicePrice = price;
      mainServicePrice = price;
      serviceName = name;
      selectServiceColor = index;

      await getServiceSpecificAddOnsApiCall(
        agencyId: agencyId ?? "",
        customerId: Constant.storage.read('customerId'),
        serviceId: serviceId,
      );
    }
    update([Constant.idGetAgencyInfo]);
  }

  void toggleAddOnService(MatchingAddOnServices service) {
    final isSelected = selectedAddOnServiceIds.contains(service.id);

    if (isSelected) {
      selectedAddOnServiceIds.remove(service.id);
      selectedAddOnServicePrices.remove(service.price.toString());

      servicePrice = mainServicePrice;
    } else {
      selectedAddOnServiceIds.add(service.id ?? "");
      selectedAddOnServicePrices.add(service.price.toString());
    }

    log("Selected Add-On Service IDs: $selectedAddOnServiceIds");
    log("Selected Add-On Service Prices: $selectedAddOnServicePrices");

    double main = double.tryParse(servicePrice ?? "0") ?? 0.0;
    double addOnTotal = selectedAddOnServicePrices.fold(
      0.0,
      (prev, element) => prev + (double.tryParse(element) ?? 0.0),
    );

    double newTotal = main + addOnTotal;
    servicePrice = newTotal.toStringAsFixed(2);

    update([Constant.idGetAgencyInfo]);
  }

  onBookNowClick() {
    Get.toNamed(
      AppRoutes.booking,
      arguments: [
        color,
        textColor,
        agencyId,
        getAgencyInfoModel?.agencyInfo?.profileImage,
        "${getAgencyInfoModel?.agencyInfo?.firstName} ${getAgencyInfoModel?.agencyInfo?.lastName}",
        serviceName,
        mainServicePrice,
        getAgencyInfoModel?.agencyInfo?.avgRating?.toStringAsFixed(1),
        selectedServiceId,
        getAgencyInfoModel?.agencyInfo?.taxRate,
        selectedAddOnServiceIds,
        selectedAddOnServicePrices.join(","),
        "", // when package is not purchase
        0, // when package is not purchase
      ],
    );
  }

  /// =================== API Calling =================== ///

  GetAgencyInfoModel? getAgencyInfoModel;
  GetAgencyWiseProviderModel? getAgencyWiseProviderModel;
  GetServiceSpecificAddOnModel? getServiceSpecificAddOnModel;
  List<GetAgencyWiseProviders> getAgencyWiseProviders = [];
  bool isLoading = false;

  getAgencyInfoApiCall({required String agencyId, required String customerId}) async {
    try {
      isLoading = true;
      update([Constant.idGetAgencyInfo, Constant.idGetAgencyWiseProvider]);

      final queryParameters = {
        "agencyId": agencyId,
        "customerId": customerId,
      };

      log("Get Agency Info Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAgencyInfo + queryString);
      log("Get Agency Info Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Agency Info Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Agency Info Status Code :: ${response.statusCode}");
      log("Get Agency Info Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAgencyInfoModel = GetAgencyInfoModel.fromJson(jsonResponse);
      }

      log("Get Agency Info Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Agency Info Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetAgencyInfo, Constant.idGetAgencyWiseProvider]);
    }
  }

  onGetAgencyWiseProviderApiCall({required String agencyId, required String start, required String limit}) async {
    try {
      isLoading = true;
      update([Constant.idGetAgencyInfo, Constant.idGetAgencyWiseProvider]);

      startAgencyWiseProvider++;

      final queryParameters = {
        "agencyId": agencyId,
        "start": start,
        "limit": limit,
      };

      log("Get Agency Wise Provider Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.listAgencyBasedProviders + queryString);
      log("Get Agency Wise Provider Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Agency Wise Provider Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Agency Wise Provider Status Code :: ${response.statusCode}");
      log("Get Agency Wise Provider Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAgencyWiseProviderModel = GetAgencyWiseProviderModel.fromJson(jsonResponse);

        if (getAgencyWiseProviderModel != null) {
          final List<GetAgencyWiseProviders> data = getAgencyWiseProviderModel?.providers ?? [];

          if (data.isNotEmpty) {
            getAgencyWiseProviders.addAll(data);
          }
        }
      }

      log("Get Agency Wise Provider Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Agency Wise Provider Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetAgencyInfo, Constant.idGetAgencyWiseProvider]);
    }
  }

  getServiceSpecificAddOnsApiCall({required String agencyId, required String customerId, required String serviceId}) async {
    try {
      isLoading = true;
      update([Constant.idGetAgencyInfo, Constant.idGetAgencyWiseProvider]);

      final queryParameters = {
        "agencyId": agencyId,
        "customerId": customerId,
        "serviceId": serviceId,
      };

      log("Get Service Specific Add Ons Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getServiceSpecificAddOns + queryString);
      log("Get Service Specific Add Ons Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Service Specific Add Ons Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Service Specific Add Ons Status Code :: ${response.statusCode}");
      log("Get Service Specific Add Ons Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getServiceSpecificAddOnModel = GetServiceSpecificAddOnModel.fromJson(jsonResponse);
      }

      log("Get Service Specific Add Ons Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Service Specific Add Ons Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetAgencyInfo, Constant.idGetAgencyWiseProvider]);
    }
  }
}
