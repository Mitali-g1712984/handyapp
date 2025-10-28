import 'dart:convert';

GetChatListModel getChatListModelFromJson(String str) => GetChatListModel.fromJson(json.decode(str));
String getChatListModelToJson(GetChatListModel data) => json.encode(data.toJson());

class GetChatListModel {
  GetChatListModel({
    bool? status,
    String? message,
    List<ChatList>? chatList,
  }) {
    _status = status;
    _message = message;
    _chatList = chatList;
  }

  GetChatListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['ChatList'] != null) {
      _chatList = [];
      json['ChatList'].forEach((v) {
        _chatList?.add(ChatList.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ChatList>? _chatList;
  GetChatListModel copyWith({
    bool? status,
    String? message,
    List<ChatList>? chatList,
  }) =>
      GetChatListModel(
        status: status ?? _status,
        message: message ?? _message,
        chatList: chatList ?? _chatList,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ChatList>? get chatList => _chatList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chatList != null) {
      map['ChatList'] = _chatList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

ChatList chatListFromJson(String str) => ChatList.fromJson(json.decode(str));
String chatListToJson(ChatList data) => json.encode(data.toJson());

class ChatList {
  ChatList({
    String? id,
    String? receiverId,
    String? receiverRole,
    String? name,
    String? profileImage,
    bool? isOnline,
    String? chatTopic,
    String? senderId,
    String? lastChatMessageTime,
    num? messageType,
    String? message,
    num? unreadCount,
    String? time,
  }) {
    _id = id;
    _receiverId = receiverId;
    _receiverRole = receiverRole;
    _name = name;
    _profileImage = profileImage;
    _isOnline = isOnline;
    _chatTopic = chatTopic;
    _senderId = senderId;
    _lastChatMessageTime = lastChatMessageTime;
    _messageType = messageType;
    _message = message;
    _unreadCount = unreadCount;
    _time = time;
  }

  ChatList.fromJson(dynamic json) {
    _id = json['_id'];
    _receiverId = json['receiverId'];
    _receiverRole = json['receiverRole'];
    _name = json['name'];
    _profileImage = json['profileImage'];
    _isOnline = json['isOnline'];
    _chatTopic = json['chatTopic'];
    _senderId = json['senderId'];
    _lastChatMessageTime = json['lastChatMessageTime'];
    _messageType = json['messageType'];
    _message = json['message'];
    _unreadCount = json['unreadCount'];
    _time = json['time'];
  }
  String? _id;
  String? _receiverId;
  String? _receiverRole;
  String? _name;
  String? _profileImage;
  bool? _isOnline;
  String? _chatTopic;
  String? _senderId;
  String? _lastChatMessageTime;
  num? _messageType;
  String? _message;
  num? _unreadCount;
  String? _time;
  ChatList copyWith({
    String? id,
    String? receiverId,
    String? receiverRole,
    String? name,
    String? profileImage,
    bool? isOnline,
    String? chatTopic,
    String? senderId,
    String? lastChatMessageTime,
    num? messageType,
    String? message,
    num? unreadCount,
    String? time,
  }) =>
      ChatList(
        id: id ?? _id,
        receiverId: receiverId ?? _receiverId,
        receiverRole: receiverRole ?? _receiverRole,
        name: name ?? _name,
        profileImage: profileImage ?? _profileImage,
        isOnline: isOnline ?? _isOnline,
        chatTopic: chatTopic ?? _chatTopic,
        senderId: senderId ?? _senderId,
        lastChatMessageTime: lastChatMessageTime ?? _lastChatMessageTime,
        messageType: messageType ?? _messageType,
        message: message ?? _message,
        unreadCount: unreadCount ?? _unreadCount,
        time: time ?? _time,
      );
  String? get id => _id;
  String? get receiverId => _receiverId;
  String? get receiverRole => _receiverRole;
  String? get name => _name;
  String? get profileImage => _profileImage;
  bool? get isOnline => _isOnline;
  String? get chatTopic => _chatTopic;
  String? get senderId => _senderId;
  String? get lastChatMessageTime => _lastChatMessageTime;
  num? get messageType => _messageType;
  String? get message => _message;
  num? get unreadCount => _unreadCount;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['receiverId'] = _receiverId;
    map['receiverRole'] = _receiverRole;
    map['name'] = _name;
    map['profileImage'] = _profileImage;
    map['isOnline'] = _isOnline;
    map['chatTopic'] = _chatTopic;
    map['senderId'] = _senderId;
    map['lastChatMessageTime'] = _lastChatMessageTime;
    map['messageType'] = _messageType;
    map['message'] = _message;
    map['unreadCount'] = _unreadCount;
    map['time'] = _time;
    return map;
  }
}
