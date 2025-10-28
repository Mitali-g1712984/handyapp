import 'dart:convert';
import 'dart:developer';

import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/booking_information_screen/model/get_appointment_info_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:handy/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingInformationController extends GetxController {
  dynamic args = Get.arguments;

  String? appointmentId;
  String? formattedTime;

  num? withOutTaxAmount;
  num? packageAmount;
  num? taxAmount;
  num? addOnServiceAmount;
  num? subTotal;
  num? discountAmount;
  num? finalAmount;

  @override
  void onInit() async {
    await getDataFromArgs();

    await getAppointmentInfoApiCall(
      customerId: Constant.storage.read('customerId'),
      appointmentId: appointmentId ?? "",
    );

    onGetBookingAmount();

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        appointmentId = args[0];
      }

      log("Get Appointment Info Appointment ID :: $appointmentId");
    }
  }

  onGetBookingAmount() {
    if (getAppointmentInfoModel?.data?.addOnService?.isEmpty == true &&
        getAppointmentInfoModel?.data?.package?.service?.isEmpty == true) {
      withOutTaxAmount = getAppointmentInfoModel?.data?.serviceProviderFee ?? 0;
      discountAmount = getAppointmentInfoModel?.data?.discountAmount ?? 0;
      taxAmount = getAppointmentInfoModel?.data?.taxAmount ?? 0;

      finalAmount = (withOutTaxAmount ?? 0) - (discountAmount ?? 0) + (taxAmount ?? 0);

      log("Final Amount :: $finalAmount");
    } else if (getAppointmentInfoModel?.data?.addOnService?.isNotEmpty == true &&
        getAppointmentInfoModel?.data?.package?.service?.isEmpty == true) {
      withOutTaxAmount = getAppointmentInfoModel?.data?.serviceProviderFee ?? 0;
      addOnServiceAmount = getAppointmentInfoModel?.data?.addOnService?.fold(0, (sum, item) => sum! + item.price!) ?? 0;
      discountAmount = getAppointmentInfoModel?.data?.discountAmount ?? 0;
      taxAmount = getAppointmentInfoModel?.data?.taxAmount ?? 0;

      subTotal = (withOutTaxAmount ?? 0) + (addOnServiceAmount ?? 0);
      finalAmount = (subTotal ?? 0) - (discountAmount ?? 0) + (taxAmount ?? 0);

      log("Sub Total :: $subTotal");
      log("Final Amount When Add On Service :: $finalAmount");
    } else {
      packageAmount = getAppointmentInfoModel?.data?.package?.price ?? 0;
      taxAmount = getAppointmentInfoModel?.data?.taxAmount ?? 0;

      finalAmount = (packageAmount ?? 0) + (taxAmount ?? 0);

      log("Final Amount When Add Package :: $finalAmount");
    }
  }

  makingAgencyPhoneCall({required String mobileNumber}) async {
    var url = Uri.parse("tel:$mobileNumber");
    await launchUrl(url);
  }

  makingAgencyMail({required String email}) async {
    var url = Uri.parse("mailto:$email");
    await launchUrl(url);
  }

  makingProviderPhoneCall({required String mobileNumber}) async {
    var url = Uri.parse("tel:$mobileNumber");
    await launchUrl(url);
  }

  makingProviderMail({required String email}) async {
    var url = Uri.parse("mailto:$email");
    await launchUrl(url);
  }

  /// =================== API Calling =================== ///

  GetAppointmentInfoModel? getAppointmentInfoModel;
  bool isLoading = false;

  getAppointmentInfoApiCall({required String customerId, required String appointmentId}) async {
    try {
      isLoading = true;
      update([Constant.idGetAppointmentInfo]);

      final queryParameters = {
        "customerId": customerId,
        "appointmentId": appointmentId,
      };

      log("Get Appointment Info Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAppointmentInfo + queryString);
      log("Get Appointment Info Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Appointment Info Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Appointment Info Status Code :: ${response.statusCode}");
      log("Get Appointment Info Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAppointmentInfoModel = GetAppointmentInfoModel.fromJson(jsonResponse);
      }

      log("Get Appointment Info Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Appointment Info Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetAppointmentInfo]);
    }
  }
}
