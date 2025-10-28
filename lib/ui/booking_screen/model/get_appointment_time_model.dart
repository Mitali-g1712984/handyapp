import 'dart:convert';

GetAppointmentTimeModel getAppointmentTimeModelFromJson(String str) => GetAppointmentTimeModel.fromJson(json.decode(str));
String getAppointmentTimeModelToJson(GetAppointmentTimeModel data) => json.encode(data.toJson());

class GetAppointmentTimeModel {
  GetAppointmentTimeModel({
    bool? status,
    String? message,
    bool? isOpen,
    bool? isBreak,
    num? timeSlot,
    List<String>? morningSlots,
    List<String>? eveningSlots,
    List<String>? busySlots,
  }) {
    _status = status;
    _message = message;
    _isOpen = isOpen;
    _isBreak = isBreak;
    _timeSlot = timeSlot;
    _morningSlots = morningSlots;
    _eveningSlots = eveningSlots;
    _busySlots = busySlots;
  }

  GetAppointmentTimeModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _isOpen = json['isOpen'];
    _isBreak = json['isBreak'];
    _timeSlot = json['timeSlot'];
    _morningSlots = json['morningSlots'] != null ? json['morningSlots'].cast<String>() : [];
    _eveningSlots = json['eveningSlots'] != null ? json['eveningSlots'].cast<String>() : [];
    _busySlots = json['busySlots'] != null ? json['busySlots'].cast<String>() : [];
  }
  bool? _status;
  String? _message;
  bool? _isOpen;
  bool? _isBreak;
  num? _timeSlot;
  List<String>? _morningSlots;
  List<String>? _eveningSlots;
  List<String>? _busySlots;
  GetAppointmentTimeModel copyWith({
    bool? status,
    String? message,
    bool? isOpen,
    bool? isBreak,
    num? timeSlot,
    List<String>? morningSlots,
    List<String>? eveningSlots,
    List<String>? busySlots,
  }) =>
      GetAppointmentTimeModel(
        status: status ?? _status,
        message: message ?? _message,
        isOpen: isOpen ?? _isOpen,
        isBreak: isBreak ?? _isBreak,
        timeSlot: timeSlot ?? _timeSlot,
        morningSlots: morningSlots ?? _morningSlots,
        eveningSlots: eveningSlots ?? _eveningSlots,
        busySlots: busySlots ?? _busySlots,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get isOpen => _isOpen;
  bool? get isBreak => _isBreak;
  num? get timeSlot => _timeSlot;
  List<String>? get morningSlots => _morningSlots;
  List<String>? get eveningSlots => _eveningSlots;
  List<String>? get busySlots => _busySlots;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['isOpen'] = _isOpen;
    map['isBreak'] = _isBreak;
    map['timeSlot'] = _timeSlot;
    map['morningSlots'] = _morningSlots;
    map['eveningSlots'] = _eveningSlots;
    map['busySlots'] = _busySlots;
    return map;
  }
}
