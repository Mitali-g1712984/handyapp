// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:handy/services/app_exception/app_exception.dart';
// import 'package:handy/ui/favorite_agency_screen/model/get_favourite_agency_model.dart';
// import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
// import 'package:handy/utils/api.dart';
// import 'package:handy/utils/constant.dart';
// import 'package:get/get.dart';
// import 'package:handy/utils/utils.dart';
// import 'package:http/http.dart' as http;
//
// class FavoriteAgencyController extends GetxController {
//   dynamic args = Get.arguments;
//   bool? isBack;
//
//   List<bool> isFavouriteAgency = [];
//
//   HomeScreenController homeScreenController = Get.find<HomeScreenController>();
//
//   @override
//   void onInit() async {
//     await getDataFromArgs();
//
//     await getFavouriteAgencyApiCall();
//
//     isFavouriteAgency = List<bool>.filled(getFavouriteAgencyModel?.data?.length ?? 0, false);
//     for (int i = 0; i < (getFavouriteAgencyModel?.data?.length ?? 0); i++) {
//       isFavouriteAgency[i] = true;
//     }
//
//     log("Favourite Agency :: $isFavouriteAgency");
//     super.onInit();
//   }
//
//   getDataFromArgs() {
//     if (args != null) {
//       if (args[0] != null) {
//         isBack = args[0];
//       }
//     }
//
//     log("Is Back :: $isBack");
//   }
//
//   onFavouriteAgency({required String customerId, required String agencyId}) async {
//     await homeScreenController.favouriteAgencyByCustomerApiCall(
//       customerId: customerId,
//       agencyId: agencyId,
//     );
//
//     if (homeScreenController.favoriteAgencyByCustomerModel?.status == true) {
//       if (homeScreenController.favoriteAgencyByCustomerModel?.isFavorite == true) {
//         Utils.showToast(Get.context!, "Agency favorite successfully");
//
//         int? index = homeScreenController.getTopRatedAgencyModel?.data?.indexWhere((element) => element.id == agencyId);
//         if (index != null) {
//           isFavouriteAgency[index] = true;
//         }
//       } else {
//         int? index = homeScreenController.getTopRatedAgencyModel?.data?.indexWhere((element) => element.id == agencyId);
//         if (index != null) {
//           isFavouriteAgency[index] = false;
//         }
//       }
//     } else {
//       Utils.showToast(Get.context!, homeScreenController.favoriteAgencyByCustomerModel?.message ?? "");
//     }
//
//     update([Constant.idServiceSaved]);
//   }
//
//   /// =================== API Calling =================== ///
//
//   GetFavouriteAgencyModel? getFavouriteAgencyModel;
//   bool isLoading = false;
//
//   getFavouriteAgencyApiCall() async {
//     try {
//       isLoading = true;
//       update([Constant.idGetFavouriteAgency]);
//
//       final queryParameters = {
//         "customerId": Constant.storage.read("customerId"),
//       };
//
//       log("Get All Favorite Agency Params :: $queryParameters");
//
//       String queryString = Uri(queryParameters: queryParameters).query;
//
//       final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getFavouriteAgency + queryString);
//       log("Get All Favorite Agency Url :: $url");
//
//       final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
//       log("Get All Favorite Agency Headers :: $headers");
//
//       var response = await http.get(url, headers: headers);
//
//       log("Get All Favorite Agency Status Code :: ${response.statusCode}");
//       log("Get All Favorite Agency Response :: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         getFavouriteAgencyModel = GetFavouriteAgencyModel.fromJson(jsonResponse);
//       }
//
//       log("Get All Favorite Agency Api Call Successfully");
//     } on AppException catch (exception) {
//       Utils.showToast(Get.context!, exception.message);
//     } catch (e) {
//       log("Error call Get All Favorite Agency Api :: $e");
//     } finally {
//       isLoading = false;
//       update([Constant.idGetFavouriteAgency]);
//     }
//   }
// }

import 'dart:convert';
import 'dart:developer';

import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/favorite_agency_screen/model/get_favourite_agency_model.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:get/get.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;

class FavoriteAgencyController extends GetxController {
  dynamic args = Get.arguments;
  bool? isBack;

  List<bool> isFavouriteAgency = <bool>[];

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  GetFavouriteAgencyModel? getFavouriteAgencyModel;
  bool isLoading = false;

  @override
  void onInit() async {
    try {
      await getDataFromArgs();
      await getFavouriteAgencyApiCall();
      initializeFavoriteStatusList();

      super.onInit();
    } catch (e) {
      log("Error in onInit: $e");
      Utils.showToast(Get.context!, "Failed to initialize favorite agencies");
    }
  }

  getDataFromArgs() {
    if (args != null && args[0] != null) {
      isBack = args[0];
    }
    log("Is Back :: $isBack");
  }

  void initializeFavoriteStatusList() {
    isFavouriteAgency.clear();

    if (getFavouriteAgencyModel?.data != null) {
      isFavouriteAgency.addAll(List.generate(getFavouriteAgencyModel!.data!.length, (index) => true));
    }

    log("Favourite Agency :: $isFavouriteAgency");
  }

  Future<void> onFavouriteAgency({required String customerId, required String agencyId}) async {
    try {
      await homeScreenController.favouriteAgencyByCustomerApiCall(
        customerId: customerId,
        agencyId: agencyId,
      );

      if (homeScreenController.favoriteAgencyByCustomerModel?.status == true) {
        final topRatedAgencies = homeScreenController.getTopRatedAgencyModel?.data;
        final index = topRatedAgencies?.indexWhere((element) => element.id == agencyId);

        if (index != null && index >= 0) {
          while (isFavouriteAgency.length <= index) {
            isFavouriteAgency.add(false);
          }

          isFavouriteAgency[index] = homeScreenController.favoriteAgencyByCustomerModel!.isFavorite!;

          if (homeScreenController.favoriteAgencyByCustomerModel!.isFavorite!) {
            Utils.showToast(Get.context!, "Agency added to favorites");
          } else {
            Utils.showToast(Get.context!, "Agency removed from favorites");
          }
        }
      } else {
        Utils.showToast(Get.context!, homeScreenController.favoriteAgencyByCustomerModel?.message ?? "");
      }

      update([Constant.idServiceSaved]);
    } catch (e) {
      log("Error in onFavouriteAgency: $e");
      Utils.showToast(Get.context!, "Failed to update favorite status");
    }
  }

  getFavouriteAgencyApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetFavouriteAgency]);

      final queryParameters = {
        "customerId": Constant.storage.read("customerId"),
      };

      log("Get All Favorite Agency Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getFavouriteAgency + queryString);
      log("Get All Favorite Agency Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get All Favorite Agency Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get All Favorite Agency Status Code :: ${response.statusCode}");
      log("Get All Favorite Agency Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getFavouriteAgencyModel = GetFavouriteAgencyModel.fromJson(jsonResponse);

        log("Get All Favorite Agency Api Call Successfully");
      }
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get All Favorite Agency Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetFavouriteAgency]);
    }
  }
}
