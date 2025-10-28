import 'dart:convert';

ClearAllNotificationModel clearAllNotificationModelFromJson(String str) => ClearAllNotificationModel.fromJson(json.decode(str));
String clearAllNotificationModelToJson(ClearAllNotificationModel data) => json.encode(data.toJson());

class ClearAllNotificationModel {
  ClearAllNotificationModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  ClearAllNotificationModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  ClearAllNotificationModel copyWith({
    bool? status,
    String? message,
  }) =>
      ClearAllNotificationModel(
        status: status ?? _status,
        message: message ?? _message,
      );
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
