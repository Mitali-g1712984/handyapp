import 'package:get/get.dart';
import 'package:handy/ui/agency_info_screen/controller/agency_info_controller.dart';
import 'package:handy/ui/purchase_package_screen/controller/purchase_package_controller.dart';

class PurchasePackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchasePackageController>(() => PurchasePackageController());
    Get.lazyPut<AgencyInfoController>(() => AgencyInfoController());
  }
}
