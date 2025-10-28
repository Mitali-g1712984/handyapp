import 'dart:convert';

SearchByCustomerModel searchByCustomerModelFromJson(String str) => SearchByCustomerModel.fromJson(json.decode(str));
String searchByCustomerModelToJson(SearchByCustomerModel data) => json.encode(data.toJson());

class SearchByCustomerModel {
  SearchByCustomerModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  SearchByCustomerModel.fromJson(dynamic json) {
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
  SearchByCustomerModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      SearchByCustomerModel(
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
    String? firstName,
    String? lastName,
    String? profileImage,
    num? avgRating,
    List<Service>? service,
    bool? isFavorite,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _profileImage = profileImage;
    _avgRating = avgRating;
    _service = service;
    _isFavorite = isFavorite;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _profileImage = json['profileImage'];
    _avgRating = json['avgRating'];
    if (json['service'] != null) {
      _service = [];
      json['service'].forEach((v) {
        _service?.add(Service.fromJson(v));
      });
    }
    _isFavorite = json['isFavorite'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _profileImage;
  num? _avgRating;
  List<Service>? _service;
  bool? _isFavorite;
  Data copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? profileImage,
    num? avgRating,
    List<Service>? service,
    bool? isFavorite,
  }) =>
      Data(
        id: id ?? _id,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        profileImage: profileImage ?? _profileImage,
        avgRating: avgRating ?? _avgRating,
        service: service ?? _service,
        isFavorite: isFavorite ?? _isFavorite,
      );
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get profileImage => _profileImage;
  num? get avgRating => _avgRating;
  List<Service>? get service => _service;
  bool? get isFavorite => _isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['profileImage'] = _profileImage;
    map['avgRating'] = _avgRating;
    if (_service != null) {
      map['service'] = _service?.map((v) => v.toJson()).toList();
    }
    map['isFavorite'] = _isFavorite;
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
