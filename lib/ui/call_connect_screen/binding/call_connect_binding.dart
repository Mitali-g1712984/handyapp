import 'package:get/get.dart';
import 'package:handy/ui/call_connect_screen/controller/call_connect_controller.dart';

class CallConnectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallConnectController>(() => CallConnectController());
  }
}
