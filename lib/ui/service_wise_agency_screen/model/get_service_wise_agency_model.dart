import 'dart:convert';

GetServiceWiseAgencyModel getServiceWiseAgencyModelFromJson(String str) => GetServiceWiseAgencyModel.fromJson(json.decode(str));
String getServiceWiseAgencyModelToJson(GetServiceWiseAgencyModel data) => json.encode(data.toJson());

class GetServiceWiseAgencyModel {
  GetServiceWiseAgencyModel({
    bool? status,
    String? message,
    List<GetServiceWiseAgencyData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetServiceWiseAgencyModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetServiceWiseAgencyData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GetServiceWiseAgencyData>? _data;
  GetServiceWiseAgencyModel copyWith({
    bool? status,
    String? message,
    List<GetServiceWiseAgencyData>? data,
  }) =>
      GetServiceWiseAgencyModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<GetServiceWiseAgencyData>? get data => _data;

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

GetServiceWiseAgencyData dataFromJson(String str) => GetServiceWiseAgencyData.fromJson(json.decode(str));
String dataToJson(GetServiceWiseAgencyData data) => json.encode(data.toJson());

class GetServiceWiseAgencyData {
  GetServiceWiseAgencyData({
    String? id,
    String? firstName,
    String? lastName,
    String? profileImage,
    num? avgRating,
    bool? isFavorite,
    String? serviceName,
    num? servicePrice,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _profileImage = profileImage;
    _avgRating = avgRating;
    _isFavorite = isFavorite;
    _serviceName = serviceName;
    _servicePrice = servicePrice;
  }

  GetServiceWiseAgencyData.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _profileImage = json['profileImage'];
    _avgRating = json['avgRating'];
    _isFavorite = json['isFavorite'];
    _serviceName = json['serviceName'];
    _servicePrice = json['servicePrice'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _profileImage;
  num? _avgRating;
  bool? _isFavorite;
  String? _serviceName;
  num? _servicePrice;
  GetServiceWiseAgencyData copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? profileImage,
    num? avgRating,
    bool? isFavorite,
    String? serviceName,
    num? servicePrice,
  }) =>
      GetServiceWiseAgencyData(
        id: id ?? _id,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        profileImage: profileImage ?? _profileImage,
        avgRating: avgRating ?? _avgRating,
        isFavorite: isFavorite ?? _isFavorite,
        serviceName: serviceName ?? _serviceName,
        servicePrice: servicePrice ?? _servicePrice,
      );
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get profileImage => _profileImage;
  num? get avgRating => _avgRating;
  bool? get isFavorite => _isFavorite;
  String? get serviceName => _serviceName;
  num? get servicePrice => _servicePrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['profileImage'] = _profileImage;
    map['avgRating'] = _avgRating;
    map['isFavorite'] = _isFavorite;
    map['serviceName'] = _serviceName;
    map['servicePrice'] = _servicePrice;
    return map;
  }
}
