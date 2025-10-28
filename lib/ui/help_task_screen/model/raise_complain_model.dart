import 'dart:convert';

RaiseComplainModel raiseComplainModelFromJson(String str) => RaiseComplainModel.fromJson(json.decode(str));
String raiseComplainModelToJson(RaiseComplainModel data) => json.encode(data.toJson());

class RaiseComplainModel {
  RaiseComplainModel({
    bool? status,
    String? message,
    ComplaintSuggestion? complaintSuggestion,
  }) {
    _status = status;
    _message = message;
    _complaintSuggestion = complaintSuggestion;
  }

  RaiseComplainModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _complaintSuggestion = json['complaintSuggestion'] != null ? ComplaintSuggestion.fromJson(json['complaintSuggestion']) : null;
  }
  bool? _status;
  String? _message;
  ComplaintSuggestion? _complaintSuggestion;
  RaiseComplainModel copyWith({
    bool? status,
    String? message,
    ComplaintSuggestion? complaintSuggestion,
  }) =>
      RaiseComplainModel(
        status: status ?? _status,
        message: message ?? _message,
        complaintSuggestion: complaintSuggestion ?? _complaintSuggestion,
      );
  bool? get status => _status;
  String? get message => _message;
  ComplaintSuggestion? get complaintSuggestion => _complaintSuggestion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_complaintSuggestion != null) {
      map['complaintSuggestion'] = _complaintSuggestion?.toJson();
    }
    return map;
  }
}

ComplaintSuggestion complaintSuggestionFromJson(String str) => ComplaintSuggestion.fromJson(json.decode(str));
String complaintSuggestionToJson(ComplaintSuggestion data) => json.encode(data.toJson());

class ComplaintSuggestion {
  ComplaintSuggestion({
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
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
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
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ComplaintSuggestion.fromJson(dynamic json) {
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
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
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
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  ComplaintSuggestion copyWith({
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
    String? id,
    String? createdAt,
    String? updatedAt,
  }) =>
      ComplaintSuggestion(
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
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
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
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
