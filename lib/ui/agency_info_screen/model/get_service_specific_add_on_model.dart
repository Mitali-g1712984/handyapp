import 'dart:convert';

GetServiceSpecificAddOnModel getServiceSpecificAddOnModelFromJson(String str) =>
    GetServiceSpecificAddOnModel.fromJson(json.decode(str));

String getServiceSpecificAddOnModelToJson(GetServiceSpecificAddOnModel data) => json.encode(data.toJson());

class GetServiceSpecificAddOnModel {
  GetServiceSpecificAddOnModel({
    bool? status,
    String? message,
    List<MatchingAddOnServices>? matchingAddOnServices,
  }) {
    _status = status;
    _message = message;
    _matchingAddOnServices = matchingAddOnServices;
  }

  GetServiceSpecificAddOnModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['matchingAddOnServices'] != null) {
      _matchingAddOnServices = [];
      json['matchingAddOnServices'].forEach((v) {
        _matchingAddOnServices?.add(MatchingAddOnServices.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<MatchingAddOnServices>? _matchingAddOnServices;

  GetServiceSpecificAddOnModel copyWith({
    bool? status,
    String? message,
    List<MatchingAddOnServices>? matchingAddOnServices,
  }) =>
      GetServiceSpecificAddOnModel(
        status: status ?? _status,
        message: message ?? _message,
        matchingAddOnServices: matchingAddOnServices ?? _matchingAddOnServices,
      );

  bool? get status => _status;

  String? get message => _message;

  List<MatchingAddOnServices>? get matchingAddOnServices => _matchingAddOnServices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_matchingAddOnServices != null) {
      map['matchingAddOnServices'] = _matchingAddOnServices?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

MatchingAddOnServices matchingAddOnServicesFromJson(String str) => MatchingAddOnServices.fromJson(json.decode(str));

String matchingAddOnServicesToJson(MatchingAddOnServices data) => json.encode(data.toJson());

class MatchingAddOnServices {
  MatchingAddOnServices({
    String? id,
    String? addOnServiceName,
    String? image,
    num? price,
    Service? service,
  }) {
    _id = id;
    _addOnServiceName = addOnServiceName;
    _image = image;
    _price = price;
    _service = service;
  }

  MatchingAddOnServices.fromJson(dynamic json) {
    _id = json['_id'];
    _addOnServiceName = json['addOnServiceName'];
    _image = json['image'];
    _price = json['price'];
    _service = json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  String? _id;
  String? _addOnServiceName;
  String? _image;
  num? _price;
  Service? _service;

  MatchingAddOnServices copyWith({
    String? id,
    String? addOnServiceName,
    String? image,
    num? price,
    Service? service,
  }) =>
      MatchingAddOnServices(
        id: id ?? _id,
        addOnServiceName: addOnServiceName ?? _addOnServiceName,
        image: image ?? _image,
        price: price ?? _price,
        service: service ?? _service,
      );

  String? get id => _id;

  String? get addOnServiceName => _addOnServiceName;

  String? get image => _image;

  num? get price => _price;

  Service? get service => _service;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['addOnServiceName'] = _addOnServiceName;
    map['image'] = _image;
    map['price'] = _price;
    if (_service != null) {
      map['service'] = _service?.toJson();
    }
    return map;
  }
}

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
    String? name,
  }) {
    _name = name;
  }

  Service.fromJson(dynamic json) {
    _name = json['name'];
  }

  String? _name;

  Service copyWith({
    String? name,
  }) =>
      Service(
        name: name ?? _name,
      );

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }
}
