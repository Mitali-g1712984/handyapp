import 'dart:async';
import 'dart:developer';

import 'package:handy/utils/constant.dart';
import 'package:get/get.dart';

class FakeVoiceCallController extends GetxController {
  bool isSpeakerOn = false;
  bool isMicMute = false;

  int selectedStarIndex = -1;

  dynamic args = Get.arguments;

  String? agencyName;
  String? agencyImage;
  DateTime? startTime;
  DateTime? endTime;
  Timer? timer;
  Duration? duration;
  int? minutes;
  int? seconds;
  String? finalDuration;
  String? formattedTime;

  @override
  void onInit() async {
    await getDataFromArgs();
    timer = Timer(
      const Duration(seconds: 30),
      () {
        timer?.cancel();
        Get.back();
      },
    );

    startTime = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final duration = DateTime.now().difference(startTime ?? DateTime.now());
      final minutes = duration.inMinutes.remainder(60);
      final seconds = duration.inSeconds.remainder(60);
      formattedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      log('Start timer :: $formattedTime');

      update([Constant.idVideoCall]);
    });

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null) {
        agencyName = args[0];
        agencyImage = args[1];
      }
      log("Agency Name :: $agencyName");
      log("Agency Image :: $agencyImage");
    }
  }

  onSpeakerOn() {
    isSpeakerOn = !isSpeakerOn;
    update([Constant.idMicMute]);
  }

  onMicMute() {
    isMicMute = !isMicMute;
    update([Constant.idVideoTurn]);
  }

  onSelectedStar(int index) {
    selectedStarIndex = index;
    update([Constant.idSelectStar]);
  }
}
