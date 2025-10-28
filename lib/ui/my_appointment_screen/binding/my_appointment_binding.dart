import 'package:get/get.dart';
import 'package:handy/ui/my_appointment_screen/controller/my_appointment_controller.dart';

class MyAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAppointmentController>(() => MyAppointmentController());
  }
}
