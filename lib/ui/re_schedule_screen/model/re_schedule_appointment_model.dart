// To parse this JSON data, do
//
//     final reScheduleAppointmentModel = reScheduleAppointmentModelFromJson(jsonString);

import 'dart:convert';

ReScheduleAppointmentModel reScheduleAppointmentModelFromJson(String str) =>
    ReScheduleAppointmentModel.fromJson(json.decode(str));

String reScheduleAppointmentModelToJson(ReScheduleAppointmentModel data) => json.encode(data.toJson());

class ReScheduleAppointmentModel {
  bool? status;
  String? message;
  Data? data;

  ReScheduleAppointmentModel({
    this.status,
    this.message,
    this.data,
  });

  factory ReScheduleAppointmentModel.fromJson(Map<String, dynamic> json) => ReScheduleAppointmentModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Coupon? coupon;
  String? id;
  String? customer;
  String? provider;
  String? service;
  int? status;
  String? appointmentId;
  String? serviceDetails;
  List<dynamic>? image;
  String? time;
  int? duration;
  DateTime? date;
  int? taxRate;
  int? taxAmount;
  int? discountAmount;
  int? serviceProviderFee;
  int? amountAfterTax;
  int? netPayableAmount;
  int? adminCommissionRate;
  double? adminCommissionAmount;
  double? providerNetEarnings;
  String? checkInTime;
  String? checkOutTime;
  bool? isReviewed;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.coupon,
    this.id,
    this.customer,
    this.provider,
    this.service,
    this.status,
    this.appointmentId,
    this.serviceDetails,
    this.image,
    this.time,
    this.duration,
    this.date,
    this.taxRate,
    this.taxAmount,
    this.discountAmount,
    this.serviceProviderFee,
    this.amountAfterTax,
    this.netPayableAmount,
    this.adminCommissionRate,
    this.adminCommissionAmount,
    this.providerNetEarnings,
    this.checkInTime,
    this.checkOutTime,
    this.isReviewed,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
        id: json["_id"],
        customer: json["customer"],
        provider: json["provider"],
        service: json["service"],
        status: json["status"],
        appointmentId: json["appointmentId"],
        serviceDetails: json["serviceDetails"],
        image: json["image"] == null ? [] : List<dynamic>.from(json["image"]!.map((x) => x)),
        time: json["time"],
        duration: json["duration"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        taxRate: json["taxRate"],
        taxAmount: json["taxAmount"],
        discountAmount: json["discountAmount"],
        serviceProviderFee: json["serviceProviderFee"],
        amountAfterTax: json["amountAfterTax"],
        netPayableAmount: json["netPayableAmount"],
        adminCommissionRate: json["adminCommissionRate"],
        adminCommissionAmount: json["adminCommissionAmount"]?.toDouble(),
        providerNetEarnings: json["providerNetEarnings"]?.toDouble(),
        checkInTime: json["checkInTime"],
        checkOutTime: json["checkOutTime"],
        isReviewed: json["isReviewed"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "coupon": coupon?.toJson(),
        "_id": id,
        "customer": customer,
        "provider": provider,
        "service": service,
        "status": status,
        "appointmentId": appointmentId,
        "serviceDetails": serviceDetails,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "time": time,
        "duration": duration,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "taxRate": taxRate,
        "taxAmount": taxAmount,
        "discountAmount": discountAmount,
        "serviceProviderFee": serviceProviderFee,
        "amountAfterTax": amountAfterTax,
        "netPayableAmount": netPayableAmount,
        "adminCommissionRate": adminCommissionRate,
        "adminCommissionAmount": adminCommissionAmount,
        "providerNetEarnings": providerNetEarnings,
        "checkInTime": checkInTime,
        "checkOutTime": checkOutTime,
        "isReviewed": isReviewed,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Coupon {
  String? title;
  String? description;
  dynamic code;
  dynamic discountType;
  dynamic maxDiscount;
  int? minAmountToApply;

  Coupon({
    this.title,
    this.description,
    this.code,
    this.discountType,
    this.maxDiscount,
    this.minAmountToApply,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        title: json["title"],
        description: json["description"],
        code: json["code"],
        discountType: json["discountType"],
        maxDiscount: json["maxDiscount"],
        minAmountToApply: json["minAmountToApply"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "code": code,
        "discountType": discountType,
        "maxDiscount": maxDiscount,
        "minAmountToApply": minAmountToApply,
      };
}
