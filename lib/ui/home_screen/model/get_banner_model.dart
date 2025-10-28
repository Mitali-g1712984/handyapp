import 'dart:convert';

GetBannerModel getBannerModelFromJson(String str) => GetBannerModel.fromJson(json.decode(str));
String getBannerModelToJson(GetBannerModel data) => json.encode(data.toJson());

class GetBannerModel {
  GetBannerModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetBannerModel.fromJson(dynamic json) {
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
  GetBannerModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      GetBannerModel(
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
    String? image,
    String? url,
    bool? isActive,
    Service? service,
    num? type,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _image = image;
    _url = url;
    _isActive = isActive;
    _service = service;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _image = json['image'];
    _url = json['url'];
    _isActive = json['isActive'];
    _service = json['service'] != null ? Service.fromJson(json['service']) : null;
    _type = json['type'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _image;
  String? _url;
  bool? _isActive;
  Service? _service;
  num? _type;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? id,
    String? image,
    String? url,
    bool? isActive,
    Service? service,
    num? type,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        image: image ?? _image,
        url: url ?? _url,
        isActive: isActive ?? _isActive,
        service: service ?? _service,
        type: type ?? _type,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get image => _image;
  String? get url => _url;
  bool? get isActive => _isActive;
  Service? get service => _service;
  num? get type => _type;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['image'] = _image;
    map['url'] = _url;
    map['isActive'] = _isActive;
    if (_service != null) {
      map['service'] = _service?.toJson();
    }
    map['type'] = _type;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));
String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
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

  Service.fromJson(dynamic json) {
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
  Service copyWith({
    String? id,
    bool? isActive,
    String? name,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      Service(
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
