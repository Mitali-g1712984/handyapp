import 'package:get/get.dart';
import 'package:handy/ui/help_desk_history_screen/controller/help_desk_history_controller.dart';

class HelpDeskHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpDeskHistoryController>(() => HelpDeskHistoryController());
  }
}
