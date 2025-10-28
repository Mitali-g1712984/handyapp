import 'dart:convert';

GetComplainModel getComplainModelFromJson(String str) => GetComplainModel.fromJson(json.decode(str));
String getComplainModelToJson(GetComplainModel data) => json.encode(data.toJson());

class GetComplainModel {
  GetComplainModel({
    bool? status,
    String? message,
    List<GetComplainData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetComplainModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetComplainData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GetComplainData>? _data;
  GetComplainModel copyWith({
    bool? status,
    String? message,
    List<GetComplainData>? data,
  }) =>
      GetComplainModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<GetComplainData>? get data => _data;

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

GetComplainData dataFromJson(String str) => GetComplainData.fromJson(json.decode(str));
String dataToJson(GetComplainData data) => json.encode(data.toJson());

class GetComplainData {
  GetComplainData({
    String? id,
    String? customer,
    String? appointmentId,
    String? details,
    String? contact,
    String? image,
    num? person,
    num? status,
    num? type,
    String? date,
    String? solveDate,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _customer = customer;
    _appointmentId = appointmentId;
    _details = details;
    _contact = contact;
    _image = image;
    _person = person;
    _status = status;
    _type = type;
    _date = date;
    _solveDate = solveDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GetComplainData.fromJson(dynamic json) {
    _id = json['_id'];
    _customer = json['customer'];
    _appointmentId = json['appointmentId'];
    _details = json['details'];
    _contact = json['contact'];
    _image = json['image'];
    _person = json['person'];
    _status = json['status'];
    _type = json['type'];
    _date = json['date'];
    _solveDate = json['solveDate'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _customer;
  String? _appointmentId;
  String? _details;
  String? _contact;
  String? _image;
  num? _person;
  num? _status;
  num? _type;
  String? _date;
  String? _solveDate;
  String? _createdAt;
  String? _updatedAt;
  GetComplainData copyWith({
    String? id,
    String? customer,
    String? appointmentId,
    String? details,
    String? contact,
    String? image,
    num? person,
    num? status,
    num? type,
    String? date,
    String? solveDate,
    String? createdAt,
    String? updatedAt,
  }) =>
      GetComplainData(
        id: id ?? _id,
        customer: customer ?? _customer,
        appointmentId: appointmentId ?? _appointmentId,
        details: details ?? _details,
        contact: contact ?? _contact,
        image: image ?? _image,
        person: person ?? _person,
        status: status ?? _status,
        type: type ?? _type,
        date: date ?? _date,
        solveDate: solveDate ?? _solveDate,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get customer => _customer;
  String? get appointmentId => _appointmentId;
  String? get details => _details;
  String? get contact => _contact;
  String? get image => _image;
  num? get person => _person;
  num? get status => _status;
  num? get type => _type;
  String? get date => _date;
  String? get solveDate => _solveDate;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['customer'] = _customer;
    map['appointmentId'] = _appointmentId;
    map['details'] = _details;
    map['contact'] = _contact;
    map['image'] = _image;
    map['person'] = _person;
    map['status'] = _status;
    map['type'] = _type;
    map['date'] = _date;
    map['solveDate'] = _solveDate;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
