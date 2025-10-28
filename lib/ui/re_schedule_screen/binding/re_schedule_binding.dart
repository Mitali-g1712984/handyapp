import 'package:get/get.dart';
import 'package:handy/ui/re_schedule_screen/controller/re_schedule_controller.dart';

class ReScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReScheduleController>(() => ReScheduleController());
  }
}
