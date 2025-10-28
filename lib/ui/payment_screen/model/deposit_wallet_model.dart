import 'dart:convert';

DepositWalletModel depositWalletModelFromJson(String str) => DepositWalletModel.fromJson(json.decode(str));
String depositWalletModelToJson(DepositWalletModel data) => json.encode(data.toJson());

class DepositWalletModel {
  DepositWalletModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  DepositWalletModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  DepositWalletModel copyWith({
    bool? status,
    String? message,
  }) =>
      DepositWalletModel(
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
