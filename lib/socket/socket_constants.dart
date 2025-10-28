class SocketConstants {
  /// =================== Default  =================== ///
  static const String eventConnect = "connect";
  static const String eventDisconnect = "disconnect";
  static const String eventConnectTimeout = "connect_timeout";
  static const String eventConnectError = "connect_error";
  static const String onSocketError = "onSocketError";
  static const String websocket = "websocket";
  static const String globalRoom = "globalRoom";

  /// =================== Message Event =================== ///
  static const String message = "message";
  static const String messageRead = "messageRead";

  /// =================== Video Call Event =================== ///
  static const String audioCallInitiated = "audioCallInitiated";
  static const String incomingAudioCall = "incomingAudioCall";
  static const String audioCallResponse = "audioCallResponse";
  static const String callCancel = "callCancel";
  static const String callDisconnect = "callDisconnect";
}
