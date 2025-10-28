import 'dart:convert';

CheckCustomerModel checkCustomerModelFromJson(String str) => CheckCustomerModel.fromJson(json.decode(str));
String checkCustomerModelToJson(CheckCustomerModel data) => json.encode(data.toJson());

class CheckCustomerModel {
  CheckCustomerModel({
    bool? status,
    String? message,
    bool? isLogin,
  }) {
    _status = status;
    _message = message;
    _isLogin = isLogin;
  }

  CheckCustomerModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _isLogin = json['isLogin'];
  }
  bool? _status;
  String? _message;
  bool? _isLogin;
  CheckCustomerModel copyWith({
    bool? status,
    String? message,
    bool? isLogin,
  }) =>
      CheckCustomerModel(
        status: status ?? _status,
        message: message ?? _message,
        isLogin: isLogin ?? _isLogin,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get isLogin => _isLogin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['isLogin'] = _isLogin;
    return map;
  }
}
