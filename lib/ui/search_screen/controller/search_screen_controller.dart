import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/services/location_service/location_service.dart';
import 'package:handy/ui/search_screen/model/get_filter_wise_agency_model.dart';
import 'package:handy/ui/search_screen/model/search_by_customer_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class SearchScreenController extends GetxController {
  List<String> selectedServices = [];
  List<String> selectedRatings = [];
  List<String> selectedLocations = [];

  List<String> ratings = ["5", "4", "3", "2", "1"];
  List<String> locations = ["Nearby", "5km", "10km", "15km"];
  List<String> getAllService = [];
  List getAllAgency = [];
  List getAllSearchAgency = [];

  List locationsName = ["nearby", "5", "10", "15"];

  TextEditingController searchController = TextEditingController();

  void onServiceSelect(String service) {
    selectedServices.contains(service) ? selectedServices.remove(service) : selectedServices.add(service);
    update([Constant.idSelectService, Constant.idApplyFilter]);
  }

  void onRatingSelect(String rating) {
    selectedRatings.contains(rating) ? selectedRatings.remove(rating) : selectedRatings.add(rating);
    update([Constant.idRatingSelect, Constant.idApplyFilter]);
  }

  void onLocationSelect(String location) {
    selectedLocations.contains(location) ? selectedLocations.remove(location) : selectedLocations.add(location);
    update([Constant.idSelectLocation, Constant.idApplyFilter]);
  }

  void searchBy({required String text}) async {
    log("Text is :: $text");

    if (text.isEmpty) {
      log("getAllProvider :: $getAllAgency");

      getAllSearchAgency = getAllAgency;
    } else {
      await searchByCustomerApiCall(
        customerId: Constant.storage.read("customerId"),
        searchString: text,
      );
    }
  }

  onApplyFilter() async {
    try {
      isLoading = true;
      update([Constant.idGetFilterWiseAgency]);

      Get.back();

      await permissions();
      await Permission.locationAlways.request();

      String finalRating = selectedRatings.isEmpty ? "" : selectedRatings.join(",");

      await getFilterWiseAgencyApiCall(
        customerId: Constant.storage.read("customerId"),
        rating: finalRating,
        service: selectedServices.join(","),
        distance: selectedLocations.isEmpty ? "" : selectedLocations.join(","),
        latitude: latitude.toString(),
        longitude: longitude.toString(),
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

    String finalRating = selectedRatings.isEmpty ? "" : selectedRatings.join(",");

    await getFilterWiseAgencyApiCall(
      customerId: Constant.storage.read("customerId"),
      rating: finalRating,
      service: selectedServices.join(","),
      distance: selectedLocations.isEmpty ? "" : selectedLocations.join(","),
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      // city: Constant.storage.read("currentCity"),
      city: "surat",
    );
  }

  /// =================== API Calling =================== ///

  SearchByCustomerModel? searchByCustomerModel;
  GetFilterWiseAgencyModel? getFilterWiseAgencyModel;
  bool isLoading = false;

  searchByCustomerApiCall({required String customerId, required String searchString}) async {
    try {
      isLoading = true;
      update([Constant.idSearchByCustomer, Constant.idGetFilterWiseAgency]);

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Search By Customer Headers :: $headers");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.searchByCustomer);
      var request = http.Request('GET', url);

      log("Search By Customer Url :: $request");

      request.body = json.encode({
        "customerId": customerId,
        "searchString": searchString,
      });

      log("Search By Customer Body :: ${request.body}");

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      log("Search By Customer Status Code :: ${response.statusCode}");

      if (response.statusCode == 200) {
        final String bookingCategory = await response.stream.bytesToString();

        log("Search By Customer Response :: $bookingCategory");
        searchByCustomerModel = SearchByCustomerModel.fromJson(json.decode(bookingCategory));

        getAllSearchAgency.clear();

        for (int i = 0; i < (searchByCustomerModel?.data?.length ?? 0); i++) {
          getAllSearchAgency.add(searchByCustomerModel?.data?[i] ?? []);
        }

        log("getAllSearchProvider :: $getAllSearchAgency");
      }
      return searchByCustomerModel;
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Search By Customer Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idSearchByCustomer, Constant.idGetFilterWiseAgency]);
    }
  }

  getFilterWiseAgencyApiCall({
    required String customerId,
    required String rating,
    required String service,
    required String distance,
    required String latitude,
    required String longitude,
    required String city,
  }) async {
    try {
      isLoading = true;
      update([Constant.idGetFilterWiseAgency]);

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Filter Wise Provider Headers :: $headers");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getFilterWiseAgency);
      var request = http.Request('GET', url);

      log("Get Filter Wise Provider Url :: $request");

      request.body = json.encode({
        "customerId": customerId,
        "rating": rating,
        "service": service,
        "distance": distance,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
      });

      log("Get Filter Wise Provider Body :: ${request.body}");

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      log("Get Filter Wise Provider Status Code :: ${response.statusCode}");

      if (response.statusCode == 200) {
        final String bookingCategory = await response.stream.bytesToString();

        log("Get Filter Wise Provider Response :: $bookingCategory");
        getFilterWiseAgencyModel = GetFilterWiseAgencyModel.fromJson(json.decode(bookingCategory));

        getAllSearchAgency.clear();

        for (int i = 0; i < (getFilterWiseAgencyModel?.data?.length ?? 0); i++) {
          getAllSearchAgency.add(getFilterWiseAgencyModel?.data?[i] ?? []);
        }

        log("getAllSearchProvider :: $getAllSearchAgency");
      }
      return getFilterWiseAgencyModel;
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Filter Wise Provider Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetFilterWiseAgency]);
    }
  }
}
