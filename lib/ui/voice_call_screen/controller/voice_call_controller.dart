import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/dialog/call_cut_dialog.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

class VoiceCallController extends GetxController {
  dynamic args = Get.arguments;
  bool micMute = false;
  bool cameraOff = false;
  bool cameraTurn = true;
  bool remoteVideoOff = true;
  bool remoteMicMute = false;

  String? callerId;
  String? receiverId;
  String? callerImage;
  String? callerName;
  String? receiverName;
  String? receiverImage;
  String? callId;
  String? receiverRole;

  Timer? timer;
  DateTime? startTime;
  DateTime? endTime;
  Duration? duration;
  int? minutes;
  int? seconds;
  String? finalDuration;
  String? formattedTime;

  Widget? localView;
  Widget? remoteView;
  int? remoteViewID;
  int? localViewID;

  @override
  void onInit() async {
    await getDataFromArgs();

    createEngine();

    startListenEvent();
    loginRoom();

    startTimer();

    super.onInit();
  }

  @override
  void onClose() {
    stopListenEvent();

    logoutRoom();

    stopTimer();
    super.onClose();
  }

  bool isSpeakerOn = true;
  bool isMicMute = true;

  int selectedStarIndex = -1;

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null ||
          args[1] != null ||
          args[2] != null ||
          args[3] != null ||
          args[4] != null ||
          args[5] != null ||
          args[6] != null ||
          args[7] != null) {
        callerId = args[0];
        receiverId = args[1];
        callerImage = args[2];
        callerName = args[3];
        receiverName = args[4];
        receiverImage = args[5];
        callId = args[6];
        receiverRole = args[7];
      }
    }

    log("callerId :: $callerId");
    log("receiverId :: $receiverId");
    log("callerImage :: $callerImage");
    log("callerName :: $callerName");
    log("receiverName :: $receiverName");
    log("receiverImage $receiverImage");
    log("callId :: $callId");
    log("receiverRole :: $receiverRole");
  }

  void startTimer() {
    ZegoExpressEngine.instance.setAudioRouteToSpeaker(true);
    ZegoExpressEngine.instance.muteSpeaker(false);

    startTime = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final duration = DateTime.now().difference(startTime ?? DateTime.now());
      final minutes = duration.inMinutes.remainder(60);
      final seconds = duration.inSeconds.remainder(60);
      formattedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      log('Start timer :: $formattedTime');

      update([Constant.idVideoCall]);
    });
  }

  void stopTimer() {
    endTime = DateTime.now();
    timer?.cancel();
    timer = null;

    duration = endTime?.difference(startTime!);
    minutes = duration?.inMinutes.remainder(60);
    seconds = duration?.inSeconds.remainder(60);
    finalDuration = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    log('Call Duration :: $duration');
    log('Final Duration :: $finalDuration');
  }

  onMicMute() {
    isMicMute = !isMicMute;
    ZegoExpressEngine.instance.muteMicrophone(isMicMute);

    update([Constant.idMicMute, Constant.idVideoCall]);
  }

  onSpeakerOn() {
    isSpeakerOn = !isSpeakerOn;
    ZegoExpressEngine.instance.setAudioRouteToSpeaker(isSpeakerOn);

    update([Constant.idSpeakerOpen, Constant.idVideoCall]);
  }

  Future<void> createEngine() async {
    await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
      int.parse(zegoAppId!),
      ZegoScenario.Default,
      appSign: kIsWeb ? null : zegoAppSignIn,
    ));
  }

  void startListenEvent() {
    Constant.storage.write("isVideoCall", true);

    ZegoExpressEngine.onRoomUserUpdate = (roomID, updateType, List<ZegoUser> userList) {
      log('onRoomUserUpdate: roomID: $roomID, updateType: ${updateType.name}, userList: ${userList.map((e) => e.userID)}');
    };

    ZegoExpressEngine.onRemoteCameraStateUpdate = (streamID, state) {
      log("Camera is :: $state");

      if (state == ZegoRemoteDeviceState.Open) {
        remoteVideoOff = true;
      } else {
        remoteVideoOff = false;
      }
      update([Constant.idVideoCall]);
    };

    ZegoExpressEngine.onRemoteMicStateUpdate = (streamID, state) {
      log("Mic Mute is :: $state");

      if (state == ZegoRemoteDeviceState.Mute) {
        remoteMicMute = true;
      } else {
        remoteMicMute = false;
      }
      update([Constant.idVideoCall]);
    };

    ZegoExpressEngine.onRoomStreamUpdate = (roomID, updateType, List<ZegoStream> streamList, extendedData) {
      log('onRoomStreamUpdate: roomID: $roomID, updateType: $updateType, streamList: ${streamList.map((e) => e.streamID)}, extendedData: $extendedData');
      if (updateType == ZegoUpdateType.Add) {
        for (final stream in streamList) {
          startPlayStream(stream.streamID);
        }
      } else {
        for (final stream in streamList) {
          stopPlayStream(stream.streamID);
        }
      }
    };

    ZegoExpressEngine.onRoomStateUpdate = (roomID, state, errorCode, extendedData) {
      log('onRoomStateUpdate: roomID: $roomID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };

    ZegoExpressEngine.onPublisherStateUpdate = (streamID, state, errorCode, extendedData) {
      log('onPublisherStateUpdate: streamID: $streamID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };
  }

  void stopListenEvent() {
    log("Enter in stop listen event");
    Constant.storage.write("isVideoCall", false);

    ZegoExpressEngine.onRoomUserUpdate = null;
    ZegoExpressEngine.onRoomStreamUpdate = null;
    ZegoExpressEngine.onRoomStateUpdate = (roomID, state, errorCode, extendedData) {
      if (state == ZegoRoomState.Disconnected) {
        ZegoExpressEngine.instance.muteMicrophone(false);
        ZegoExpressEngine.instance.enableCamera(true);
        ZegoExpressEngine.instance.useFrontCamera(true);

        stopTimer();

        Get.dialog(
          barrierColor: AppColors.black.withOpacity(0.8),
          barrierDismissible: false,
          Dialog(
            backgroundColor: AppColors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            child: CallCutDialog(
              image: callerId != Constant.storage.read("customerId") ? callerImage ?? "" : receiverImage ?? "",
              name: callerId != Constant.storage.read("customerId") ? callerName ?? "" : receiverName ?? "",
              duration: finalDuration ?? "",
            ),
          ),
        );
      }
    };
    ZegoExpressEngine.onPublisherStateUpdate = null;
  }

  Future<void> startPlayStream(String streamID) async {
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      remoteViewID = viewID;
      ZegoCanvas canvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas);
    }).then((canvasViewWidget) {
      remoteView = canvasViewWidget;
      update([Constant.idVideoCall]);
    });
  }

  Future<void> stopPlayStream(String streamID) async {
    ZegoExpressEngine.instance.stopPlayingStream(streamID);
    if (remoteViewID != null) {
      ZegoExpressEngine.instance.destroyCanvasView(remoteViewID!);

      /// setState
      remoteViewID = null;
      remoteView = null;
      update([Constant.idVideoCall]);
    }
  }

  Future<ZegoRoomLoginResult> loginRoom() async {
    await logoutRoom();
    final user = ZegoUser(Constant.storage.read("customerId"), Constant.storage.read("customerName"));

    final roomID = callId;

    ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig()..isUserStatusNotify = true;

    return ZegoExpressEngine.instance.loginRoom(roomID!, user, config: roomConfig).then((ZegoRoomLoginResult loginRoomResult) {
      log('loginRoom: errorCode:${loginRoomResult.errorCode}, extendedData:${loginRoomResult.extendedData}');
      if (loginRoomResult.errorCode == 0) {
        startPreview();
        startPublish();
      } else {
        log("Login Room Failed Status Code :: ${loginRoomResult.errorCode}");
      }
      return loginRoomResult;
    });
  }

  Future<ZegoRoomLogoutResult> logoutRoom() async {
    stopPreview();
    stopPublish();
    return ZegoExpressEngine.instance.logoutRoom(callId);
  }

  Future<void> startPreview() async {
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      localViewID = viewID;
      ZegoCanvas previewCanvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPreview(canvas: previewCanvas);
    }).then((canvasViewWidget) {
      ///SetState
      localView = canvasViewWidget;
      update([Constant.idVideoCall]);
    });
  }

  Future<void> stopPreview() async {
    ZegoExpressEngine.instance.stopPreview();
    if (localViewID != null) {
      await ZegoExpressEngine.instance.destroyCanvasView(localViewID!);

      ///setState
      localViewID = null;
      localView = null;
      update([Constant.idVideoCall]);
    }
  }

  Future<void> startPublish() async {
    String streamID = '${callId}_${Constant.storage.read("customerId")}_call';

    return ZegoExpressEngine.instance.startPublishingStream(streamID);
  }

  Future<void> stopPublish() async {
    return ZegoExpressEngine.instance.stopPublishingStream();
  }
}
