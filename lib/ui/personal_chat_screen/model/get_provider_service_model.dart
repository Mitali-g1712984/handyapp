import 'dart:convert';

GetProviderServiceModel getProviderServiceModelFromJson(String str) => GetProviderServiceModel.fromJson(json.decode(str));
String getProviderServiceModelToJson(GetProviderServiceModel data) => json.encode(data.toJson());

class GetProviderServiceModel {
  GetProviderServiceModel({
    bool? status,
    String? message,
    List<GetProviderServiceData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetProviderServiceModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetProviderServiceData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GetProviderServiceData>? _data;
  GetProviderServiceModel copyWith({
    bool? status,
    String? message,
    List<GetProviderServiceData>? data,
  }) =>
      GetProviderServiceModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<GetProviderServiceData>? get data => _data;

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

GetProviderServiceData dataFromJson(String str) => GetProviderServiceData.fromJson(json.decode(str));
String dataToJson(GetProviderServiceData data) => json.encode(data.toJson());

class GetProviderServiceData {
  GetProviderServiceData({
    ServiceId? serviceId,
    num? price,
    String? id,
  }) {
    _serviceId = serviceId;
    _price = price;
    _id = id;
  }

  GetProviderServiceData.fromJson(dynamic json) {
    _serviceId = json['serviceId'] != null ? ServiceId.fromJson(json['serviceId']) : null;
    _price = json['price'];
    _id = json['_id'];
  }
  ServiceId? _serviceId;
  num? _price;
  String? _id;
  GetProviderServiceData copyWith({
    ServiceId? serviceId,
    num? price,
    String? id,
  }) =>
      GetProviderServiceData(
        serviceId: serviceId ?? _serviceId,
        price: price ?? _price,
        id: id ?? _id,
      );
  ServiceId? get serviceId => _serviceId;
  num? get price => _price;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_serviceId != null) {
      map['serviceId'] = _serviceId?.toJson();
    }
    map['price'] = _price;
    map['_id'] = _id;
    return map;
  }
}

ServiceId serviceIdFromJson(String str) => ServiceId.fromJson(json.decode(str));
String serviceIdToJson(ServiceId data) => json.encode(data.toJson());

class ServiceId {
  ServiceId({
    String? id,
    bool? isActive,
    String? name,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _isActive = isActive;
    _name = name;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ServiceId.fromJson(dynamic json) {
    _id = json['_id'];
    _isActive = json['isActive'];
    _name = json['name'];
    _image = json['image'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  bool? _isActive;
  String? _name;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  ServiceId copyWith({
    String? id,
    bool? isActive,
    String? name,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      ServiceId(
        id: id ?? _id,
        isActive: isActive ?? _isActive,
        name: name ?? _name,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  bool? get isActive => _isActive;
  String? get name => _name;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['isActive'] = _isActive;
    map['name'] = _name;
    map['image'] = _image;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
