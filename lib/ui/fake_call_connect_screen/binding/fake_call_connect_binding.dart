import 'package:get/get.dart';
import 'package:handy/ui/fake_call_connect_screen/controller/fake_call_connect_controller.dart';

class FakeCallConnectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FakeCallConnectController>(() => FakeCallConnectController());
  }
}
