import 'package:handy/ui/voice_call_screen/controller/voice_call_controller.dart';
import 'package:get/get.dart';

class VoiceCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoiceCallController>(() => VoiceCallController());
  }
}
