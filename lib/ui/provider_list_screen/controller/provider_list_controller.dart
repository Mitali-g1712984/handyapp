import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/provider_list_screen/model/get_agency_wise_provider_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ProviderListController extends GetxController {
  dynamic args = Get.arguments;

  String? agencyId;

  int startAgencyWiseProvider = 1;
  int limitAgencyWiseProvider = 20;

  @override
  void onInit() async {
    await getDataFromArgs();

    await onGetAgencyWiseProviderApiCall(
      agencyId: agencyId ?? "",
      start: startAgencyWiseProvider.toString(),
      limit: limitAgencyWiseProvider.toString(),
    );
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        agencyId = args[0];
      }

      log("Agency ID :: $agencyId");
    }
  }

  makingPhoneCall({required String mobileNumber}) async {
    var url = Uri.parse("tel:$mobileNumber");
    await launchUrl(url);
  }

  makingMail({required String email}) async {
    var url = Uri.parse("mailto:$email");
    await launchUrl(url);
  }

  /// =================== API Calling =================== ///

  GetAgencyWiseProviderModel? getAgencyWiseProviderModel;
  List<GetAgencyWiseProviders> getAgencyWiseProviders = [];
  bool isLoading = false;
  bool isLoading1 = false;

  onGetAgencyWiseProviderApiCall({required String agencyId, required String start, required String limit}) async {
    try {
      isLoading = true;
      update([Constant.idGetAgencyWiseProvider]);

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
      update([Constant.idGetAgencyWiseProvider]);
    }
  }
}
