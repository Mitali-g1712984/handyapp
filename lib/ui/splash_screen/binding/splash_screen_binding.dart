import 'package:handy/ui/history_screen/controller/history_screen_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/ui/splash_screen/controller/splash_screen_controller.dart';
import 'package:get/get.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
    Get.lazyPut<HistoryScreenController>(() => HistoryScreenController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
