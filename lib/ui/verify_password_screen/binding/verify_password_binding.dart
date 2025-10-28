import 'package:get/get.dart';
import 'package:handy/ui/forgot_password_screen/controller/forgot_password_controller.dart';
import 'package:handy/ui/main_screen/controller/main_screen_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/ui/verify_password_screen/controller/verify_password_controller.dart';

class VerifyPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyPasswordController>(() => VerifyPasswordController());
    Get.lazyPut<MainScreenController>(() => MainScreenController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
