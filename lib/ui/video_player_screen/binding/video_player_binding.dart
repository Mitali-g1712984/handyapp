import 'package:get/get.dart';
import 'package:handy/ui/video_player_screen/controller/video_player_controller.dart';

class VideoPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoPlayerScreenController>(() => VideoPlayerScreenController());
  }
}
