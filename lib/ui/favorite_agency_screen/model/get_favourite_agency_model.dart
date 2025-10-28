import 'dart:convert';

GetFavouriteAgencyModel getFavouriteAgencyModelFromJson(String str) => GetFavouriteAgencyModel.fromJson(json.decode(str));
String getFavouriteAgencyModelToJson(GetFavouriteAgencyModel data) => json.encode(data.toJson());

class GetFavouriteAgencyModel {
  GetFavouriteAgencyModel({
    bool? status,
    List<FavoriteAgencyData>? data,
  }) {
    _status = status;
    _data = data;
  }

  GetFavouriteAgencyModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FavoriteAgencyData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<FavoriteAgencyData>? _data;
  GetFavouriteAgencyModel copyWith({
    bool? status,
    List<FavoriteAgencyData>? data,
  }) =>
      GetFavouriteAgencyModel(
        status: status ?? _status,
        data: data ?? _data,
      );
  bool? get status => _status;
  List<FavoriteAgencyData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

FavoriteAgencyData dataFromJson(String str) => FavoriteAgencyData.fromJson(json.decode(str));
String dataToJson(FavoriteAgencyData data) => json.encode(data.toJson());

class FavoriteAgencyData {
  FavoriteAgencyData({
    String? id,
    String? firstName,
    String? lastName,
    num? avgRating,
    String? profileImage,
    List<Service>? service,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _avgRating = avgRating;
    _profileImage = profileImage;
    _service = service;
  }

  FavoriteAgencyData.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _avgRating = json['avgRating'];
    _profileImage = json['profileImage'];
    if (json['service'] != null) {
      _service = [];
      json['service'].forEach((v) {
        _service?.add(Service.fromJson(v));
      });
    }
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  num? _avgRating;
  String? _profileImage;
  List<Service>? _service;
  FavoriteAgencyData copyWith({
    String? id,
    String? firstName,
    String? lastName,
    num? avgRating,
    String? profileImage,
    List<Service>? service,
  }) =>
      FavoriteAgencyData(
        id: id ?? _id,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        avgRating: avgRating ?? _avgRating,
        profileImage: profileImage ?? _profileImage,
        service: service ?? _service,
      );
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  num? get avgRating => _avgRating;
  String? get profileImage => _profileImage;
  List<Service>? get service => _service;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['avgRating'] = _avgRating;
    map['profileImage'] = _profileImage;
    if (_service != null) {
      map['service'] = _service?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));
String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
    String? serviceId,
    String? name,
    String? image,
    bool? isActive,
    num? price,
    num? blockSize,
    String? id,
  }) {
    _serviceId = serviceId;
    _name = name;
    _image = image;
    _isActive = isActive;
    _price = price;
    _blockSize = blockSize;
    _id = id;
  }

  Service.fromJson(dynamic json) {
    _serviceId = json['serviceId'];
    _name = json['name'];
    _image = json['image'];
    _isActive = json['isActive'];
    _price = json['price'];
    _blockSize = json['blockSize'];
    _id = json['_id'];
  }
  String? _serviceId;
  String? _name;
  String? _image;
  bool? _isActive;
  num? _price;
  num? _blockSize;
  String? _id;
  Service copyWith({
    String? serviceId,
    String? name,
    String? image,
    bool? isActive,
    num? price,
    num? blockSize,
    String? id,
  }) =>
      Service(
        serviceId: serviceId ?? _serviceId,
        name: name ?? _name,
        image: image ?? _image,
        isActive: isActive ?? _isActive,
        price: price ?? _price,
        blockSize: blockSize ?? _blockSize,
        id: id ?? _id,
      );
  String? get serviceId => _serviceId;
  String? get name => _name;
  String? get image => _image;
  bool? get isActive => _isActive;
  num? get price => _price;
  num? get blockSize => _blockSize;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceId'] = _serviceId;
    map['name'] = _name;
    map['image'] = _image;
    map['isActive'] = _isActive;
    map['price'] = _price;
    map['blockSize'] = _blockSize;
    map['_id'] = _id;
    return map;
  }
}
