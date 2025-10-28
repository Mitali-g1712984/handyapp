import 'package:get/get.dart';
import 'package:handy/ui/appointment_screen/controller/appointment_screen_controller.dart';

class AppointmentScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentScreenController>(() => AppointmentScreenController());
  }
}
