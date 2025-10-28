import 'dart:convert';

GetServiceModel getServiceModelFromJson(String str) => GetServiceModel.fromJson(json.decode(str));
String getServiceModelToJson(GetServiceModel data) => json.encode(data.toJson());

class GetServiceModel {
  GetServiceModel({
    bool? status,
    String? message,
    List<GetServiceData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetServiceModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetServiceData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GetServiceData>? _data;
  GetServiceModel copyWith({
    bool? status,
    String? message,
    List<GetServiceData>? data,
  }) =>
      GetServiceModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<GetServiceData>? get data => _data;

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

GetServiceData dataFromJson(String str) => GetServiceData.fromJson(json.decode(str));
String dataToJson(GetServiceData data) => json.encode(data.toJson());

class GetServiceData {
  GetServiceData({
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

  GetServiceData.fromJson(dynamic json) {
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
  GetServiceData copyWith({
    String? id,
    bool? isActive,
    String? name,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      GetServiceData(
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
