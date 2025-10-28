import 'package:handy/ui/agency_info_screen/controller/agency_info_controller.dart';
import 'package:get/get.dart';

class AgencyInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgencyInfoController>(() => AgencyInfoController());
  }
}
