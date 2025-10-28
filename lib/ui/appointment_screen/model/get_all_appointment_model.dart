// To parse this JSON data, do
//
//     final getAllAppointmentModel = getAllAppointmentModelFromJson(jsonString);

import 'dart:convert';

GetAllAppointmentModel getAllAppointmentModelFromJson(String str) => GetAllAppointmentModel.fromJson(json.decode(str));

String getAllAppointmentModelToJson(GetAllAppointmentModel data) => json.encode(data.toJson());

class GetAllAppointmentModel {
  bool? status;
  String? message;
  List<GetAllAppointmentData>? data;

  GetAllAppointmentModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllAppointmentModel.fromJson(Map<String, dynamic> json) => GetAllAppointmentModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GetAllAppointmentData>.from(json["data"]!.map((x) => GetAllAppointmentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetAllAppointmentData {
  String? id;
  String? agency;
  List<AddOnService>? addOnService;
  Package? package;
  num? agencyApproval;
  num? status;
  String? appointmentId;
  String? time;
  String? date;
  num? serviceProviderFee;
  String? serviceId;
  String? serviceName;
  String? serviceImage;
  String? providerId;
  String? providerName;
  String? providerProfileImage;
  String? agencyName;
  num? agencyavgRating;
  bool? isReviewed;

  GetAllAppointmentData({
    this.id,
    this.agency,
    this.addOnService,
    this.package,
    this.agencyApproval,
    this.status,
    this.appointmentId,
    this.time,
    this.date,
    this.serviceProviderFee,
    this.serviceId,
    this.serviceName,
    this.serviceImage,
    this.providerId,
    this.providerName,
    this.providerProfileImage,
    this.agencyName,
    this.agencyavgRating,
    this.isReviewed,
  });

  factory GetAllAppointmentData.fromJson(Map<String, dynamic> json) => GetAllAppointmentData(
        id: json["_id"],
        agency: json["agency"],
        addOnService: json["addOnService"] == null
            ? []
            : List<AddOnService>.from(json["addOnService"]!.map((x) => AddOnService.fromJson(x))),
        package: json["package"] == null ? null : Package.fromJson(json["package"]),
        agencyApproval: json["agencyApproval"],
        status: json["status"],
        appointmentId: json["appointmentId"],
        time: json["time"],
        date: json["date"],
        serviceProviderFee: json["serviceProviderFee"],
        serviceId: json["serviceId"],
        serviceName: json["serviceName"],
        serviceImage: json["serviceImage"],
        providerId: json["providerId"],
        providerName: json["providerName"],
        providerProfileImage: json["providerProfileImage"],
        agencyName: json["agencyName"],
        agencyavgRating: json["agencyavgRating"],
        isReviewed: json["isReviewed"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "agency": agency,
        "addOnService": addOnService == null ? [] : List<dynamic>.from(addOnService!.map((x) => x.toJson())),
        "package": package?.toJson(),
        "agencyApproval": agencyApproval,
        "status": status,
        "appointmentId": appointmentId,
        "time": time,
        "date": date,
        "serviceProviderFee": serviceProviderFee,
        "serviceId": serviceId,
        "serviceName": serviceName,
        "serviceImage": serviceImage,
        "providerId": providerId,
        "providerName": providerName,
        "providerProfileImage": providerProfileImage,
        "agencyName": agencyName,
        "agencyavgRating": agencyavgRating,
        "isReviewed": isReviewed,
      };
}

class AddOnService {
  String? addOnServiceName;
  String? image;
  num? price;
  AddOnServiceService? service;
  String? id;

  AddOnService({
    this.addOnServiceName,
    this.image,
    this.price,
    this.service,
    this.id,
  });

  factory AddOnService.fromJson(Map<String, dynamic> json) => AddOnService(
        addOnServiceName: json["addOnServiceName"],
        image: json["image"],
        price: json["price"],
        service: json["service"] == null ? null : AddOnServiceService.fromJson(json["service"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "addOnServiceName": addOnServiceName,
        "image": image,
        "price": price,
        "service": service?.toJson(),
        "_id": id,
      };
}

class AddOnServiceService {
  String? name;
  num? price;

  AddOnServiceService({
    this.name,
    this.price,
  });

  factory AddOnServiceService.fromJson(Map<String, dynamic> json) => AddOnServiceService(
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}

class Package {
  String? packageName;
  String? description;
  num? price;
  String? image;
  List<ServiceElement>? service;

  Package({
    this.packageName,
    this.description,
    this.price,
    this.image,
    this.service,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageName: json["packageName"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
        service:
            json["service"] == null ? [] : List<ServiceElement>.from(json["service"]!.map((x) => ServiceElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "packageName": packageName,
        "description": description,
        "price": price,
        "image": image,
        "service": service == null ? [] : List<dynamic>.from(service!.map((x) => x.toJson())),
      };
}

class ServiceElement {
  String? name;
  String? image;
  num? price;
  String? id;

  ServiceElement({
    this.name,
    this.image,
    this.price,
    this.id,
  });

  factory ServiceElement.fromJson(Map<String, dynamic> json) => ServiceElement(
        name: json["name"],
        image: json["image"],
        price: json["price"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "price": price,
        "_id": id,
      };
}
