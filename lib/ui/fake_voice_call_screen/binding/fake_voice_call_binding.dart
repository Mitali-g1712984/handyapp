import 'package:get/get.dart';
import 'package:handy/ui/fake_voice_call_screen/controller/fake_voice_call_controller.dart';

class FakeVoiceCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FakeVoiceCallController>(() => FakeVoiceCallController());
  }
}
