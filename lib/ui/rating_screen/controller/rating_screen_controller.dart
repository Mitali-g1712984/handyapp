import 'dart:convert';
import 'dart:developer';

import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/rating_screen/model/get_review_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:handy/utils/constant.dart';

class RatingScreenController extends GetxController {
  dynamic args = Get.arguments;
  String? providerId;
  num? rating;
  int? roundedRating;
  int? filledStars;

  @override
  void onInit() async {
    await getDataFromArgs();

    await getReviewApiCall(providerId: providerId ?? "");
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        providerId = args[0];
      }

      log("Provider Id :: $providerId");
    }
  }

  /// =================== API Calling =================== ///

  GetReviewModel? getReviewModel;
  bool isLoading = false;

  getReviewApiCall({required String providerId}) async {
    try {
      isLoading = true;
      update([Constant.idGetReview]);

      final queryParameters = {
        "providerId": providerId,
      };

      log("Get Get Review Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getReview + queryString);
      log("Get Get Review Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Get Review Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Get Review Status Code :: ${response.statusCode}");
      log("Get Get Review Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getReviewModel = GetReviewModel.fromJson(jsonResponse);
      }

      log("Get Get Review Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Get Review Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetReview]);
    }
  }
}
