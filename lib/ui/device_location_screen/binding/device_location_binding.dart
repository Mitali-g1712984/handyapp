import 'package:get/get.dart';
import 'package:handy/ui/device_location_screen/controller/device_location_controller.dart';
import 'package:handy/ui/splash_screen/controller/splash_screen_controller.dart';

class DeviceLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeviceLocationController>(() => DeviceLocationController());
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}
