import 'dart:convert';

GetCouponAmountModel getCouponAmountModelFromJson(String str) => GetCouponAmountModel.fromJson(json.decode(str));
String getCouponAmountModelToJson(GetCouponAmountModel data) => json.encode(data.toJson());

class GetCouponAmountModel {
  GetCouponAmountModel({
    bool? status,
    String? message,
    num? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetCouponAmountModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
  }
  bool? _status;
  String? _message;
  num? _data;
  GetCouponAmountModel copyWith({
    bool? status,
    String? message,
    num? data,
  }) =>
      GetCouponAmountModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  num? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }
}
