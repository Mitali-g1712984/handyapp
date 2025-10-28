import 'package:get/get.dart';
import 'package:handy/ui/confirm_appointment_screen/controller/confirm_appointment_controller.dart';

class ConfirmAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmAppointmentController>(() => ConfirmAppointmentController());
  }
}
