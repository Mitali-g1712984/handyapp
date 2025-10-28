import 'package:get/get.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/service_wise_agency_screen/controller/service_wise_agency_controller.dart';

class ServiceWiseAgencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceWiseAgencyController>(() => ServiceWiseAgencyController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}
