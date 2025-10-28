import 'dart:developer';

import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/agency_info_screen/controller/agency_info_controller.dart';
import 'package:handy/ui/agency_info_screen/model/get_agency_info_model.dart';

class PurchasePackageController extends GetxController {
  dynamic args = Get.arguments;

  MatchingPackage? matchingPackage;

  AgencyInfoController agencyInfoController = Get.find<AgencyInfoController>();

  @override
  void onInit() async {
    await getDataFromArgs();

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        matchingPackage = args[0];
      }
    }

    log("matchingPackage :: $matchingPackage");
  }

  onBookNowClick() {
    Get.toNamed(
      AppRoutes.booking,
      arguments: [
        agencyInfoController.color,
        agencyInfoController.textColor,
        agencyInfoController.agencyId,
        agencyInfoController.getAgencyInfoModel?.agencyInfo?.profileImage,
        "${agencyInfoController.getAgencyInfoModel?.agencyInfo?.firstName} ${agencyInfoController.getAgencyInfoModel?.agencyInfo?.lastName}",
        matchingPackage?.service?.first.name,
        matchingPackage?.service?.first.price.toString(),
        agencyInfoController.getAgencyInfoModel?.agencyInfo?.avgRating?.toStringAsFixed(1),
        matchingPackage?.service?.first.serviceId,
        agencyInfoController.getAgencyInfoModel?.agencyInfo?.taxRate,
        agencyInfoController.selectedAddOnServiceIds,
        agencyInfoController.selectedAddOnServicePrices.join(","),
        matchingPackage?.id,
        matchingPackage?.price,
      ],
    );
  }
}
