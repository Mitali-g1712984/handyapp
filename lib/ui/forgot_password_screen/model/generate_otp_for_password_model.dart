import 'dart:convert';

GenerateOtpForPasswordModel generateOtpForPasswordModelFromJson(String str) =>
    GenerateOtpForPasswordModel.fromJson(json.decode(str));
String generateOtpForPasswordModelToJson(GenerateOtpForPasswordModel data) => json.encode(data.toJson());

class GenerateOtpForPasswordModel {
  GenerateOtpForPasswordModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  GenerateOtpForPasswordModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  GenerateOtpForPasswordModel copyWith({
    bool? status,
    String? message,
  }) =>
      GenerateOtpForPasswordModel(
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
