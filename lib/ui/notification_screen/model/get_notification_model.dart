import 'dart:convert';

GetNotificationModel getNotificationModelFromJson(String str) => GetNotificationModel.fromJson(json.decode(str));
String getNotificationModelToJson(GetNotificationModel data) => json.encode(data.toJson());

class GetNotificationModel {
  GetNotificationModel({
    bool? status,
    String? message,
    List<Notification>? notification,
  }) {
    _status = status;
    _message = message;
    _notification = notification;
  }

  GetNotificationModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['notification'] != null) {
      _notification = [];
      json['notification'].forEach((v) {
        _notification?.add(Notification.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Notification>? _notification;
  GetNotificationModel copyWith({
    bool? status,
    String? message,
    List<Notification>? notification,
  }) =>
      GetNotificationModel(
        status: status ?? _status,
        message: message ?? _message,
        notification: notification ?? _notification,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Notification>? get notification => _notification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_notification != null) {
      map['notification'] = _notification?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Notification notificationFromJson(String str) => Notification.fromJson(json.decode(str));
String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  Notification({
    String? id,
    String? customer,
    num? notificationPersonType,
    String? title,
    String? message,
    String? date,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _customer = customer;
    _notificationPersonType = notificationPersonType;
    _title = title;
    _message = message;
    _date = date;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Notification.fromJson(dynamic json) {
    _id = json['_id'];
    _customer = json['customer'];
    _notificationPersonType = json['notificationPersonType'];
    _title = json['title'];
    _message = json['message'];
    _date = json['date'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _customer;
  num? _notificationPersonType;
  String? _title;
  String? _message;
  String? _date;
  String? _createdAt;
  String? _updatedAt;
  Notification copyWith({
    String? id,
    String? customer,
    num? notificationPersonType,
    String? title,
    String? message,
    String? date,
    String? createdAt,
    String? updatedAt,
  }) =>
      Notification(
        id: id ?? _id,
        customer: customer ?? _customer,
        notificationPersonType: notificationPersonType ?? _notificationPersonType,
        title: title ?? _title,
        message: message ?? _message,
        date: date ?? _date,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get customer => _customer;
  num? get notificationPersonType => _notificationPersonType;
  String? get title => _title;
  String? get message => _message;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['customer'] = _customer;
    map['notificationPersonType'] = _notificationPersonType;
    map['title'] = _title;
    map['message'] = _message;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
