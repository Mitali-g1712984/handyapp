import 'dart:convert';

DeleteCustomerProfileModel deleteCustomerProfileModelFromJson(String str) =>
    DeleteCustomerProfileModel.fromJson(json.decode(str));
String deleteCustomerProfileModelToJson(DeleteCustomerProfileModel data) => json.encode(data.toJson());

class DeleteCustomerProfileModel {
  DeleteCustomerProfileModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  DeleteCustomerProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  DeleteCustomerProfileModel copyWith({
    bool? status,
    String? message,
  }) =>
      DeleteCustomerProfileModel(
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
