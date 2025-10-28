import 'package:get/get.dart';
import 'package:handy/ui/login_screen/controller/login_screen_controller.dart';
import 'package:handy/ui/main_screen/controller/main_screen_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
    Get.lazyPut<MainScreenController>(() => MainScreenController());
  }
}
