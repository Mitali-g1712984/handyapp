import 'dart:convert';

GetOldChatModel getOldChatModelFromJson(String str) => GetOldChatModel.fromJson(json.decode(str));
String getOldChatModelToJson(GetOldChatModel data) => json.encode(data.toJson());

class GetOldChatModel {
  GetOldChatModel({
    bool? status,
    String? message,
    String? chatTopic,
    List<GetOldChat>? chat,
  }) {
    _status = status;
    _message = message;
    _chatTopic = chatTopic;
    _chat = chat;
  }

  GetOldChatModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chatTopic = json['chatTopic'];
    if (json['chat'] != null) {
      _chat = [];
      json['chat'].forEach((v) {
        _chat?.add(GetOldChat.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  String? _chatTopic;
  List<GetOldChat>? _chat;
  GetOldChatModel copyWith({
    bool? status,
    String? message,
    String? chatTopic,
    List<GetOldChat>? chat,
  }) =>
      GetOldChatModel(
        status: status ?? _status,
        message: message ?? _message,
        chatTopic: chatTopic ?? _chatTopic,
        chat: chat ?? _chat,
      );
  bool? get status => _status;
  String? get message => _message;
  String? get chatTopic => _chatTopic;
  List<GetOldChat>? get chat => _chat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['chatTopic'] = _chatTopic;
    if (_chat != null) {
      map['chat'] = _chat?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

GetOldChat chatFromJson(String str) => GetOldChat.fromJson(json.decode(str));
String chatToJson(GetOldChat data) => json.encode(data.toJson());

class GetOldChat {
  GetOldChat({
    String? id,
    String? chatTopic,
    String? message,
    String? image,
    String? video,
    bool? isRead,
    String? date,
    dynamic callId,
    String? senderId,
    num? messageType,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _chatTopic = chatTopic;
    _message = message;
    _image = image;
    _video = video;
    _isRead = isRead;
    _date = date;
    _callId = callId;
    _senderId = senderId;
    _messageType = messageType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GetOldChat.fromJson(dynamic json) {
    _id = json['_id'];
    _chatTopic = json['chatTopic'];
    _message = json['message'];
    _image = json['image'];
    _video = json['video'];
    _isRead = json['isRead'];
    _date = json['date'];
    _callId = json['callId'];
    _senderId = json['senderId'];
    _messageType = json['messageType'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _chatTopic;
  String? _message;
  String? _image;
  String? _video;
  bool? _isRead;
  String? _date;
  dynamic _callId;
  String? _senderId;
  num? _messageType;
  String? _createdAt;
  String? _updatedAt;
  GetOldChat copyWith({
    String? id,
    String? chatTopic,
    String? message,
    String? image,
    String? video,
    bool? isRead,
    String? date,
    dynamic callId,
    String? senderId,
    num? messageType,
    String? createdAt,
    String? updatedAt,
  }) =>
      GetOldChat(
        id: id ?? _id,
        chatTopic: chatTopic ?? _chatTopic,
        message: message ?? _message,
        image: image ?? _image,
        video: video ?? _video,
        isRead: isRead ?? _isRead,
        date: date ?? _date,
        callId: callId ?? _callId,
        senderId: senderId ?? _senderId,
        messageType: messageType ?? _messageType,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get chatTopic => _chatTopic;
  String? get message => _message;
  String? get image => _image;
  String? get video => _video;
  bool? get isRead => _isRead;
  String? get date => _date;
  dynamic get callId => _callId;
  String? get senderId => _senderId;
  num? get messageType => _messageType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['chatTopic'] = _chatTopic;
    map['message'] = _message;
    map['image'] = _image;
    map['video'] = _video;
    map['isRead'] = _isRead;
    map['date'] = _date;
    map['callId'] = _callId;
    map['senderId'] = _senderId;
    map['messageType'] = _messageType;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
