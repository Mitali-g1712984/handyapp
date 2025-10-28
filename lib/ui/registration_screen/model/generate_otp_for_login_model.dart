import 'dart:convert';

GenerateOtpForLoginModel generateOtpForLoginModelFromJson(String str) => GenerateOtpForLoginModel.fromJson(json.decode(str));
String generateOtpForLoginModelToJson(GenerateOtpForLoginModel data) => json.encode(data.toJson());

class GenerateOtpForLoginModel {
  GenerateOtpForLoginModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  GenerateOtpForLoginModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  GenerateOtpForLoginModel copyWith({
    bool? status,
    String? message,
  }) =>
      GenerateOtpForLoginModel(
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
