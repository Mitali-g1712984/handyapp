import 'dart:convert';

CancelAppointmentModel cancelAppointmentModelFromJson(String str) => CancelAppointmentModel.fromJson(json.decode(str));
String cancelAppointmentModelToJson(CancelAppointmentModel data) => json.encode(data.toJson());

class CancelAppointmentModel {
  CancelAppointmentModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  CancelAppointmentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  CancelAppointmentModel copyWith({
    bool? status,
    String? message,
  }) =>
      CancelAppointmentModel(
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
