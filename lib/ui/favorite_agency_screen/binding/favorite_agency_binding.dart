import 'package:get/get.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/favorite_agency_screen/controller/favorite_agency_controller.dart';

class FavoriteAgencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteAgencyController>(() => FavoriteAgencyController(), fenix: true);
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}
