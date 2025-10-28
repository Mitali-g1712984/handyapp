import 'package:handy/ui/fake_personal_chat_screen/controller/fake_personal_chat_controller.dart';
import 'package:get/get.dart';

class FakePersonalChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FakePersonalChatController>(() => FakePersonalChatController());
  }
}
