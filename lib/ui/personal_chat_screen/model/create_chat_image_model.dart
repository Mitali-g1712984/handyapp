import 'dart:convert';

CreateChatImageModel createChatImageModelFromJson(String str) => CreateChatImageModel.fromJson(json.decode(str));
String createChatImageModelToJson(CreateChatImageModel data) => json.encode(data.toJson());

class CreateChatImageModel {
  CreateChatImageModel({
    bool? status,
    String? message,
    Chat? chat,
  }) {
    _status = status;
    _message = message;
    _chat = chat;
  }

  CreateChatImageModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
  }
  bool? _status;
  String? _message;
  Chat? _chat;
  CreateChatImageModel copyWith({
    bool? status,
    String? message,
    Chat? chat,
  }) =>
      CreateChatImageModel(
        status: status ?? _status,
        message: message ?? _message,
        chat: chat ?? _chat,
      );
  bool? get status => _status;
  String? get message => _message;
  Chat? get chat => _chat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chat != null) {
      map['chat'] = _chat?.toJson();
    }
    return map;
  }
}

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));
String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  Chat({
    String? chatTopic,
    String? message,
    String? image,
    String? video,
    bool? isRead,
    String? date,
    dynamic callId,
    String? id,
    String? senderId,
    num? messageType,
    String? createdAt,
    String? updatedAt,
  }) {
    _chatTopic = chatTopic;
    _message = message;
    _image = image;
    _video = video;
    _isRead = isRead;
    _date = date;
    _callId = callId;
    _id = id;
    _senderId = senderId;
    _messageType = messageType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Chat.fromJson(dynamic json) {
    _chatTopic = json['chatTopic'];
    _message = json['message'];
    _image = json['image'];
    _video = json['video'];
    _isRead = json['isRead'];
    _date = json['date'];
    _callId = json['callId'];
    _id = json['_id'];
    _senderId = json['senderId'];
    _messageType = json['messageType'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _chatTopic;
  String? _message;
  String? _image;
  String? _video;
  bool? _isRead;
  String? _date;
  dynamic _callId;
  String? _id;
  String? _senderId;
  num? _messageType;
  String? _createdAt;
  String? _updatedAt;
  Chat copyWith({
    String? chatTopic,
    String? message,
    String? image,
    String? video,
    bool? isRead,
    String? date,
    dynamic callId,
    String? id,
    String? senderId,
    num? messageType,
    String? createdAt,
    String? updatedAt,
  }) =>
      Chat(
        chatTopic: chatTopic ?? _chatTopic,
        message: message ?? _message,
        image: image ?? _image,
        video: video ?? _video,
        isRead: isRead ?? _isRead,
        date: date ?? _date,
        callId: callId ?? _callId,
        id: id ?? _id,
        senderId: senderId ?? _senderId,
        messageType: messageType ?? _messageType,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get chatTopic => _chatTopic;
  String? get message => _message;
  String? get image => _image;
  String? get video => _video;
  bool? get isRead => _isRead;
  String? get date => _date;
  dynamic get callId => _callId;
  String? get id => _id;
  String? get senderId => _senderId;
  num? get messageType => _messageType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chatTopic'] = _chatTopic;
    map['message'] = _message;
    map['image'] = _image;
    map['video'] = _video;
    map['isRead'] = _isRead;
    map['date'] = _date;
    map['callId'] = _callId;
    map['_id'] = _id;
    map['senderId'] = _senderId;
    map['messageType'] = _messageType;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
