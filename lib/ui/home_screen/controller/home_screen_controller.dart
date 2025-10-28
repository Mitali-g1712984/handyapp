import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/services/location_service/location_service.dart';
import 'package:handy/ui/home_screen/model/favorite_agency_by_customer_model.dart';
import 'package:handy/ui/home_screen/model/get_banner_model.dart';
import 'package:handy/ui/home_screen/model/get_service_model.dart';
import 'package:handy/ui/home_screen/model/get_top_rated_agency_model.dart';
import 'package:handy/ui/home_screen/model/get_upcoming_appointment_model.dart';
import 'package:handy/ui/search_screen/controller/search_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;

class HomeScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController? tabController;
  PageController pageController = PageController();

  List<bool> isFavouriteAgency = [];

  List? bannersImages;
  List? type;

  int selectedService = -1;
  String? serviceId;
  String? servicePrice;
  String? serviceName;

  SearchScreenController searchScreenController = Get.put(SearchScreenController());

  @override
  void onInit() async {
    log("Enter In Home screen Controller");

    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
    await getTopRatedAgencyApiCall();
    await getServiceApiCall();
    await getBannerApiCall();

    // await getCurrentLocation();
    // await getUpcomingAppointmentApiCall();

    super.onInit();
  }

  onRefreshData() async {
    await getTopRatedAgencyApiCall();
    await getServiceApiCall();
    await getBannerApiCall();
    // await getUpcomingAppointmentApiCall();
  }

  onFavouriteAgency({required String customerId, required String agencyId}) async {
    await favouriteAgencyByCustomerApiCall(
      customerId: customerId,
      agencyId: agencyId,
    );

    if (favoriteAgencyByCustomerModel?.status == true) {
      if (favoriteAgencyByCustomerModel?.isFavorite == true) {
        Utils.showToast(Get.context!, "Agency favorite successfully");

        int? index = getTopRatedAgencyModel?.data?.indexWhere((element) => element.id == agencyId);
        if (index != null) {
          isFavouriteAgency[index] = true;
        }
      } else {
        int? index = getTopRatedAgencyModel?.data?.indexWhere((element) => element.id == agencyId);
        if (index != null) {
          isFavouriteAgency[index] = false;
        }
      }
    } else {
      Utils.showToast(Get.context!, favoriteAgencyByCustomerModel?.message ?? "");
    }

    update([Constant.idServiceSaved]);
  }

  Future<Position> getUserLocationPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!serviceEnabled) {
      log("Services Enabled :: $serviceEnabled");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
        throw 'Location Permission Denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location Permission Denied Permanently';
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      return value;
    }).catchError((e) async {
      return await Geolocator.getLastKnownPosition().then((value) async {
        if (value != null) {
          return value;
        } else {
          throw 'Enable Location';
        }
      }).catchError((e) {
        log("Error in get current position : $e");
        Utils.showToast(Get.context!, e);
        return e;
      });
    });
  }

  getCurrentLocation() async {
    try {
      isLoading = true;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedAgency, Constant.idGetUpcomingAppointment]);

      await getUserLocationPosition().then((position) async {
        setAddress();

        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 18.0),
          ),
        );

        markers.clear();
        markers.add(Marker(
          markerId: MarkerId(currentAddress),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: 'Start $currentAddress', snippet: destinationAddress),
          icon: BitmapDescriptor.defaultMarker,
        ));

        Constant.storage.write("latitude", position.latitude);
        Constant.storage.write("longitude", position.longitude);

        String? city = await getCityName(position.latitude, position.longitude);
        log("User's Current City: $city");

        Constant.storage.write("userAddress", currentAddress);
        Constant.storage.write("currentCity", city);

        homeScreenController.update([Constant.idGetLocation]);
      }).catchError((e) {
        log("Catch Error in Get Current Location :: $e");
      });
    } catch (e) {
      log("Failed to get location :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedAgency, Constant.idGetUpcomingAppointment]);
    }
  }

  Widget imageView(String image) {
    return CachedNetworkImage(
      imageUrl: "${ApiConstant.BASE_URL}$image",
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return Image.asset(AppAsset.icPlaceholderImage).paddingAll(40);
      },
      errorWidget: (context, url, error) {
        return Image.asset(AppAsset.icPlaceholderImage).paddingAll(40);
      },
    );
  }

  onSelectService(int index) {
    if (selectedService == index) {
      selectedService = -1;
    } else {
      selectedService = index;
    }
    update([Constant.idServiceSelected]);
  }

  /// =================== API Calling =================== ///

  GetServiceModel? getServiceModel;
  GetBannerModel? getBannerModel;
  GetTopRatedAgencyModel? getTopRatedAgencyModel;
  FavoriteAgencyByCustomerModel? favoriteAgencyByCustomerModel;
  GetUpcomingAppointmentModel? getUpcomingAppointmentModel;
  bool isLoading = false;

  getServiceApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedAgency, Constant.idGetUpcomingAppointment]);

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getService);
      log("Get Service Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Service Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Service Status Code :: ${response.statusCode}");
      log("Get Service Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getServiceModel = GetServiceModel.fromJson(jsonResponse);

        searchScreenController.getAllService.clear();

        for (int i = 0; i < (getServiceModel?.data?.length ?? 0); i++) {
          searchScreenController.getAllService.add(getServiceModel?.data?[i].name ?? "");
        }
        log("Get All Category :: ${searchScreenController.getAllService}");
      }

      log("Get Service Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Service Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedAgency, Constant.idGetUpcomingAppointment]);
    }
  }

  getBannerApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedAgency, Constant.idGetUpcomingAppointment]);

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getBanner);
      log("Get Banner Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Banner Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Banner Status Code :: ${response.statusCode}");
      log("Get Banner Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getBannerModel = GetBannerModel.fromJson(jsonResponse);
      }

      log("Get Banner Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Banner Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedAgency, Constant.idGetUpcomingAppointment]);
    }
  }

  getTopRatedAgencyApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedAgency, Constant.idGetUpcomingAppointment]);

      final queryParameters = {
        "customerId": Constant.storage.read("customerId"),
        // "city": Constant.storage.read("currentCity"),
        "city": "surat",
      };

      log("Get Top Rated Agency Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getTopRatedAgency + queryString);
      log("Get Top Rated Agency Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Top Rated Agency Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Top Rated Agency Status Code :: ${response.statusCode}");
      log("Get Top Rated Agency Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getTopRatedAgencyModel = GetTopRatedAgencyModel.fromJson(jsonResponse);

        searchScreenController.getAllAgency.clear();
        searchScreenController.getAllSearchAgency.clear();

        searchScreenController.getAllAgency.addAll(getTopRatedAgencyModel?.data ?? []);
        searchScreenController.getAllSearchAgency.addAll(getTopRatedAgencyModel?.data ?? []);
        log("Get All Agency :: ${searchScreenController.getAllAgency}");

        isFavouriteAgency.clear();
        for (int i = 0; i < (getTopRatedAgencyModel?.data?.length ?? 0); i++) {
          isFavouriteAgency.add(getTopRatedAgencyModel?.data?[i].isFavorite ?? false);
        }

        log("Favourite Agency :: $isFavouriteAgency");
      }

      log("Get Top Rated Agency Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Top Rated Agency Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedAgency, Constant.idGetUpcomingAppointment]);
    }
  }

  favouriteAgencyByCustomerApiCall({required String customerId, required String agencyId}) async {
    try {
      isLoading = true;
      update([Constant.idFavouriteAgencyByCustomer]);

      final queryParameters = {
        "customerId": customerId,
        "agencyId": agencyId,
      };

      log("Favourite Agency By Customer Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.favoriteAgencyByCustomer + queryString);
      log("Favourite Agency By Customer Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Favourite Agency By Customer Headers :: $headers");

      var response = await http.post(url, headers: headers);

      log("Favourite Agency By Customer Status Code :: ${response.statusCode}");
      log("Favourite Agency By Customer Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        favoriteAgencyByCustomerModel = FavoriteAgencyByCustomerModel.fromJson(jsonResponse);
      }

      log("Favourite Agency By Customer Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Favourite Agency By Customer Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idFavouriteAgencyByCustomer]);
    }
  }

  getUpcomingAppointmentApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedAgency, Constant.idGetUpcomingAppointment]);

      final queryParameters = {
        "customerId": Constant.storage.read("customerId"),
      };

      log("Get Upcoming Appointment Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getUpcomingAppointment + queryString);
      log("Get Upcoming Appointment Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Upcoming Appointment Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Upcoming Appointment Status Code :: ${response.statusCode}");
      log("Get Upcoming Appointment Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getUpcomingAppointmentModel = GetUpcomingAppointmentModel.fromJson(jsonResponse);
      }

      log("Get Upcoming Appointment Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Upcoming Appointment Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedAgency, Constant.idGetUpcomingAppointment]);
    }
  }
}
