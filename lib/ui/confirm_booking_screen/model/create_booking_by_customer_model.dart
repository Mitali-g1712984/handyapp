import 'dart:convert';

CreateBookingByCustomerModel createBookingByCustomerModelFromJson(String str) =>
    CreateBookingByCustomerModel.fromJson(json.decode(str));
String createBookingByCustomerModelToJson(CreateBookingByCustomerModel data) => json.encode(data.toJson());

class CreateBookingByCustomerModel {
  CreateBookingByCustomerModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  CreateBookingByCustomerModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  CreateBookingByCustomerModel copyWith({
    bool? status,
    String? message,
  }) =>
      CreateBookingByCustomerModel(
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
