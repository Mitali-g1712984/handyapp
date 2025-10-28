import 'package:get/get.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/search_screen/controller/search_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<SearchScreenController>(() => SearchScreenController());
  }
}
