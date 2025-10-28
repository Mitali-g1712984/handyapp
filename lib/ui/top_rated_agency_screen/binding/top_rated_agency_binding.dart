import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/top_rated_agency_screen/controller/top_rated_agency_controller.dart';
import 'package:get/get.dart';

class TopRatedAgencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopRatedAgencyController>(() => TopRatedAgencyController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}
