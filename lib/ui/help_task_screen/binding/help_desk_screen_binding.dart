import 'package:get/get.dart';
import 'package:handy/ui/help_task_screen/controller/help_desk_screen_controller.dart';

class HelpDeskScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpDeskScreenController>(() => HelpDeskScreenController());
  }
}
