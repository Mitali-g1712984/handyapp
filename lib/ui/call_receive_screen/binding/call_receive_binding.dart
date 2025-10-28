import 'package:get/get.dart';
import 'package:handy/ui/call_receive_screen/controller/call_receive_controller.dart';

class CallReceiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallReceiveController>(() => CallReceiveController());
  }
}
