import 'dart:convert';

GetCouponModel getCouponModelFromJson(String str) => GetCouponModel.fromJson(json.decode(str));
String getCouponModelToJson(GetCouponModel data) => json.encode(data.toJson());

class GetCouponModel {
  GetCouponModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetCouponModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
  GetCouponModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      GetCouponModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    String? code,
    String? title,
    String? description,
    num? minAmountToApply,
    num? discountPercent,
    num? maxDiscount,
    String? expiryDate,
    num? type,
    num? discountType,
    bool? isActive,
    List<UsedBy>? usedBy,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _code = code;
    _title = title;
    _description = description;
    _minAmountToApply = minAmountToApply;
    _discountPercent = discountPercent;
    _maxDiscount = maxDiscount;
    _expiryDate = expiryDate;
    _type = type;
    _discountType = discountType;
    _isActive = isActive;
    _usedBy = usedBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _code = json['code'];
    _title = json['title'];
    _description = json['description'];
    _minAmountToApply = json['minAmountToApply'];
    _discountPercent = json['discountPercent'];
    _maxDiscount = json['maxDiscount'];
    _expiryDate = json['expiryDate'];
    _type = json['type'];
    _discountType = json['discountType'];
    _isActive = json['isActive'];
    if (json['usedBy'] != null) {
      _usedBy = [];
      json['usedBy'].forEach((v) {
        _usedBy?.add(UsedBy.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _code;
  String? _title;
  String? _description;
  num? _minAmountToApply;
  num? _discountPercent;
  num? _maxDiscount;
  String? _expiryDate;
  num? _type;
  num? _discountType;
  bool? _isActive;
  List<UsedBy>? _usedBy;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    num? minAmountToApply,
    num? discountPercent,
    num? maxDiscount,
    String? expiryDate,
    num? type,
    num? discountType,
    bool? isActive,
    List<UsedBy>? usedBy,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        code: code ?? _code,
        title: title ?? _title,
        description: description ?? _description,
        minAmountToApply: minAmountToApply ?? _minAmountToApply,
        discountPercent: discountPercent ?? _discountPercent,
        maxDiscount: maxDiscount ?? _maxDiscount,
        expiryDate: expiryDate ?? _expiryDate,
        type: type ?? _type,
        discountType: discountType ?? _discountType,
        isActive: isActive ?? _isActive,
        usedBy: usedBy ?? _usedBy,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get code => _code;
  String? get title => _title;
  String? get description => _description;
  num? get minAmountToApply => _minAmountToApply;
  num? get discountPercent => _discountPercent;
  num? get maxDiscount => _maxDiscount;
  String? get expiryDate => _expiryDate;
  num? get type => _type;
  num? get discountType => _discountType;
  bool? get isActive => _isActive;
  List<UsedBy>? get usedBy => _usedBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['code'] = _code;
    map['title'] = _title;
    map['description'] = _description;
    map['minAmountToApply'] = _minAmountToApply;
    map['discountPercent'] = _discountPercent;
    map['maxDiscount'] = _maxDiscount;
    map['expiryDate'] = _expiryDate;
    map['type'] = _type;
    map['discountType'] = _discountType;
    map['isActive'] = _isActive;
    if (_usedBy != null) {
      map['usedBy'] = _usedBy?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

UsedBy usedByFromJson(String str) => UsedBy.fromJson(json.decode(str));
String usedByToJson(UsedBy data) => json.encode(data.toJson());

class UsedBy {
  UsedBy({
    String? customerId,
    num? usageType,
    String? id,
  }) {
    _customerId = customerId;
    _usageType = usageType;
    _id = id;
  }

  UsedBy.fromJson(dynamic json) {
    _customerId = json['customerId'];
    _usageType = json['usageType'];
    _id = json['_id'];
  }
  String? _customerId;
  num? _usageType;
  String? _id;
  UsedBy copyWith({
    String? customerId,
    num? usageType,
    String? id,
  }) =>
      UsedBy(
        customerId: customerId ?? _customerId,
        usageType: usageType ?? _usageType,
        id: id ?? _id,
      );
  String? get customerId => _customerId;
  num? get usageType => _usageType;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customerId'] = _customerId;
    map['usageType'] = _usageType;
    map['_id'] = _id;
    return map;
  }
}
