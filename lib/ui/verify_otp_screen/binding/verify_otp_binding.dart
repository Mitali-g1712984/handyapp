import 'package:get/get.dart';
import 'package:handy/ui/main_screen/controller/main_screen_controller.dart';
import 'package:handy/ui/mobile_number_screen/controller/mobile_number_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/ui/verify_otp_screen/controller/verify_otp_controller.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyOtpController>(() => VerifyOtpController());
    Get.lazyPut<MobileNumberController>(() => MobileNumberController());
    Get.lazyPut<MainScreenController>(() => MainScreenController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
