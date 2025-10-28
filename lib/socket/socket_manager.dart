import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/socket/socket_constants.dart';
import 'package:handy/ui/personal_chat_screen/model/get_old_chat_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketManager {
  static io.Socket? socket;
  static List setMessageList = [];
  static String receiverRoleId = "";
  static RxBool chatUpdate = false.obs;
  static ScrollController scrollController = ScrollController();

  ///----------> Initialize Socket Connection
  static initSocketManager() {
    socket = io.io(
      ApiConstant.BASE_URL,
      io.OptionBuilder().setTransports([SocketConstants.websocket]).setQuery(
        {SocketConstants.globalRoom: "${SocketConstants.globalRoom}:${Constant.storage.read("customerId")}"},
      ).build(),
    );

    socket?.connect();
    socketGlobalListeners();
  }

  ///----------> To Emit Event Into Socket
  static bool? emit(String event, Map<String, dynamic> data) {
    log("Socket Emit $event :: $data");
    socket?.emit(event, jsonDecode(json.encode(data)));
    return socket?.connected;
  }

  ///----------> Socket on data listen
  static socketGlobalListeners() {
    socket?.on(SocketConstants.eventConnect, onConnect);
    socket?.on(SocketConstants.eventDisconnect, onDisconnect);
    socket?.on(SocketConstants.onSocketError, onConnectError);
    socket?.on(SocketConstants.eventConnectTimeout, onConnectError);
    socket?.on(SocketConstants.eventConnectError, onEventConnectError);
    socket?.on(SocketConstants.message, onMessage);
    socket?.on(SocketConstants.messageRead, onMessageRead);
    socket?.on(SocketConstants.audioCallInitiated, onAudioCallInitiated);
    socket?.on(SocketConstants.incomingAudioCall, onIncomingAudioCall);
    socket?.on(SocketConstants.audioCallResponse, onAudioCallResponse);
    socket?.on(SocketConstants.callCancel, onCallCancel);
    socket?.on(SocketConstants.callDisconnect, onCallDisconnect);
  }

  ///----------> Get This Event After Successful Connection To Socket
  static onConnect(connect) {
    log("Socket Connected....................");
  }

  ///----------> Get This Event After Connection Lost To Socket Due To Network Or Any Other Reason
  static onDisconnect(disconnect) {
    log("Socket Disconnected....................$disconnect");
  }

  ///----------> Get This Event After Connection Error To Socket With Error
  static onConnectError(error) {
    log("Socket ConnectError.................... $error");
  }

  ///----------> Get This Event After Connection Error To Socket With Error
  static onEventConnectError(error) {
    log("Socket Event Connect Error.................... $error");
  }

  ///----------> Get This Event When User Send Message
  static void onMessage(dynamic message) async {
    log("Socket On Message :: $message");

    if (message != null) {
      if (message['messageType'] == '1') {
        setMessage(
          senderId: message['senderId'],
          message: message['message'],
          messageType: message['messageType'],
          date: message['date'],
          image: message['image'],
          video: message['video'],
        );
      } else {
        setMessage(
          senderId: message['senderId'],
          message: message['message'],
          messageType: message['messageType'],
          date: message['date'],
          image: message['image'],
          video: message['video'],
        );
      }
    }
  }

  ///----------> Get This Event When User See(Read) Message
  static void onMessageRead(dynamic messageRead) async {
    log("Socket On Message Read :: $messageRead");
  }

  ///----------> Get This Event When Click on Audio call button
  static onAudioCallInitiated(dynamic audioCallInitiated) async {
    log("Socket On Audio Call Initiated :: $audioCallInitiated");

    if (audioCallInitiated != null) {
      Constant.storage.write("callId", audioCallInitiated['callId']);
      log("Call Id :: ${Constant.storage.read("callId")}");

      if (audioCallInitiated['callerId'] == Constant.storage.read("customerId")) {
        Get.toNamed(AppRoutes.callConnect, arguments: [
          audioCallInitiated['callerId'],
          audioCallInitiated['receiverId'],
          audioCallInitiated['callerImage'],
          audioCallInitiated['callerName'],
          audioCallInitiated['receiverName'],
          audioCallInitiated['receiverImage'],
          audioCallInitiated['callId'],
          audioCallInitiated['receiverRole'],
        ]);
      } else {
        Get.toNamed(AppRoutes.callReceive, arguments: [
          audioCallInitiated['callerId'],
          audioCallInitiated['receiverId'],
          audioCallInitiated['callerImage'],
          audioCallInitiated['callerName'],
          audioCallInitiated['receiverName'],
          audioCallInitiated['receiverImage'],
          audioCallInitiated['callId'],
          audioCallInitiated['role'],
        ]);
      }
    }
  }

  ///----------> Get This Event When Received Incoming Audio Call
  static onIncomingAudioCall(dynamic incomingAudioCall) async {
    log("Socket On Incoming Audio Call :: $incomingAudioCall");

    if (incomingAudioCall != null) {
      Constant.storage.write("callId", incomingAudioCall['callId']);
      log("Call Id :: ${Constant.storage.read("callId")}");

      if (incomingAudioCall['callerId'] == Constant.storage.read("customerId")) {
        Get.toNamed(AppRoutes.callConnect, arguments: [
          incomingAudioCall['callerId'],
          incomingAudioCall['receiverId'],
          incomingAudioCall['callerImage'],
          incomingAudioCall['callerName'],
          incomingAudioCall['receiverName'],
          incomingAudioCall['receiverImage'],
          incomingAudioCall['callId'],
          incomingAudioCall['callerId'] == Constant.storage.read("customerId")
              ? incomingAudioCall['receiverRole']
              : incomingAudioCall['role'],
        ]);
      } else {
        Get.toNamed(AppRoutes.callReceive, arguments: [
          incomingAudioCall['callerId'],
          incomingAudioCall['receiverId'],
          incomingAudioCall['callerImage'],
          incomingAudioCall['callerName'],
          incomingAudioCall['receiverName'],
          incomingAudioCall['receiverImage'],
          incomingAudioCall['callId'],
          incomingAudioCall['callerId'] == Constant.storage.read("customerId")
              ? incomingAudioCall['receiverRole']
              : incomingAudioCall['role'],
        ]);
      }
    }
  }

  ///----------> Get This Event when accept OR decline the audio call
  static onAudioCallResponse(dynamic audioCallResponse) async {
    log("Socket On Audio Call Response :: $audioCallResponse");

    Constant.storage.write("callId", audioCallResponse['callId']);
    log("Call Id :: ${Constant.storage.read("callId")}");

    if (audioCallResponse['isAccept'] == true) {
      Get.offNamed(AppRoutes.videoCall, arguments: [
        audioCallResponse['callerId'],
        audioCallResponse['receiverId'],
        audioCallResponse['callerImage'],
        audioCallResponse['callerName'],
        audioCallResponse['receiverName'],
        audioCallResponse['receiverImage'],
        audioCallResponse['callId'],
        audioCallResponse['callerId'] == Constant.storage.read("customerId")
            ? audioCallResponse['receiverRole']
            : audioCallResponse['role'],
      ]);
    } else {
      Get.back();
    }
  }

  ///----------> Get This Event for when caller cut the call
  static onCallCancel(dynamic callCancel) async {
    log("Socket On Call Cancel :: $callCancel");

    Get.back();
  }

  ///----------> Get This Event for disconnect call after call receive
  static onCallDisconnect(dynamic callDisconnect) async {
    log("Socket On Call Disconnect :: $callDisconnect");

    Get.back();
  }

  ///----------> Get socket data and set in the list
  static setMessage({
    required String senderId,
    required String message,
    required int messageType,
    required String date,
    required String image,
    required String video,
  }) {
    GetOldChat getOldChat = GetOldChat(
      chatTopic: '',
      senderId: senderId,
      message: message,
      messageType: messageType,
      date: date,
      image: image,
      video: video,
    );

    log("receiverRoleId -------------------- $receiverRoleId");
    log("senderId --------------------$senderId");

    if (receiverRoleId == senderId) {
      log("Enter if --------------------");
      setMessageList.add(getOldChat);
    } else {
      if (senderId == Constant.storage.read("customerId")) {
        setMessageList.add(getOldChat);
        log("Enter else --------------------");
      }
    }

    onScrollDown();
    onChatUpdate();
  }

  ///----------> Scroll when message set in list
  static Future<void> onScrollDown() async {
    try {
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      log("Scroll Down Failed :: $e");
    }
  }

  ///----------> When image set in list
  static onChatUpdate() {
    chatUpdate.value = !chatUpdate.value;
  }
}
