import 'package:get/get.dart';
import 'package:handy/ui/main_screen/controller/main_screen_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainScreenController>(() => MainScreenController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
