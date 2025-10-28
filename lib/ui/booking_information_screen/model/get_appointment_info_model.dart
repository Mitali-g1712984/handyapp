import 'dart:convert';

GetAppointmentInfoModel getAppointmentInfoModelFromJson(String str) => GetAppointmentInfoModel.fromJson(json.decode(str));

String getAppointmentInfoModelToJson(GetAppointmentInfoModel data) => json.encode(data.toJson());

class GetAppointmentInfoModel {
  bool? status;
  String? message;
  Data? data;

  GetAppointmentInfoModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetAppointmentInfoModel.fromJson(Map<String, dynamic> json) {
    var parsedData = json["data"];
    if (parsedData is List) {
      parsedData = parsedData.isNotEmpty ? parsedData[0] : null;
    }

    return GetAppointmentInfoModel(
      status: json["status"],
      message: json["message"],
      data: parsedData == null ? null : Data.fromJson(parsedData),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
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
  num? discountAmount;
  num? taxAmount;
  String? checkInTime;
  String? checkOutTime;
  Cancel? cancel;
  String? serviceId;
  String? serviceName;
  String? serviceImage;
  String? agencyName;
  String? agencyMobileNumber;
  String? agencyEmail;
  String? agencyProfileImage;
  String? providerId;
  String? providerName;
  String? providerProfileImage;
  String? providerMobileNumber;
  String? providerEmail;
  num? provideravgRating;

  Data({
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
    this.discountAmount,
    this.taxAmount,
    this.checkInTime,
    this.checkOutTime,
    this.cancel,
    this.serviceId,
    this.serviceName,
    this.serviceImage,
    this.agencyName,
    this.agencyMobileNumber,
    this.agencyEmail,
    this.agencyProfileImage,
    this.providerId,
    this.providerName,
    this.providerProfileImage,
    this.providerMobileNumber,
    this.providerEmail,
    this.provideravgRating,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        agency: json["agency"],
        addOnService: json["addOnService"] is List
            ? List<AddOnService>.from(json["addOnService"].map((x) => AddOnService.fromJson(x)))
            : [],
        package: json["package"] is Map ? Package.fromJson(json["package"]) : null,
        agencyApproval: json["agencyApproval"],
        status: json["status"],
        appointmentId: json["appointmentId"],
        time: json["time"],
        date: json["date"],
        serviceProviderFee: json["serviceProviderFee"],
        discountAmount: json["discountAmount"],
        taxAmount: json["taxAmount"]?.toDouble(),
        checkInTime: json["checkInTime"],
        checkOutTime: json["checkOutTime"],
        cancel: json["cancel"] == null ? null : Cancel.fromJson(json["cancel"]),
        serviceId: json["serviceId"],
        serviceName: json["serviceName"],
        serviceImage: json["serviceImage"],
        agencyName: json["agencyName"],
        agencyMobileNumber: json["agencyMobileNumber"],
        agencyEmail: json["agencyEmail"],
        agencyProfileImage: json["agencyProfileImage"],
        providerId: json["providerId"],
        providerName: json["providerName"],
        providerProfileImage: json["providerProfileImage"],
        providerMobileNumber: json["providerMobileNumber"],
        providerEmail: json["providerEmail"],
        provideravgRating: json["provideravgRating"],
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
        "discountAmount": discountAmount,
        "taxAmount": taxAmount,
        "checkInTime": checkInTime,
        "checkOutTime": checkOutTime,
        "cancel": cancel?.toJson(),
        "serviceId": serviceId,
        "serviceName": serviceName,
        "serviceImage": serviceImage,
        "agencyName": agencyName,
        "agencyMobileNumber": agencyMobileNumber,
        "agencyEmail": agencyEmail,
        "agencyProfileImage": agencyProfileImage,
        "providerId": providerId,
        "providerName": providerName,
        "providerProfileImage": providerProfileImage,
        "providerMobileNumber": providerMobileNumber,
        "providerEmail": providerEmail,
        "provideravgRating": provideravgRating,
      };
}

class AddOnService {
  String? addOnServiceName;
  String? image;
  num? price;

  AddOnService({this.addOnServiceName, this.image, this.price});

  factory AddOnService.fromJson(Map<String, dynamic> json) => AddOnService(
        addOnServiceName: json["addOnServiceName"],
        image: json["image"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "addOnServiceName": addOnServiceName,
        "image": image,
        "price": price,
      };
}

class Cancel {
  int? person;
  String? reason;
  String? time;
  String? date;

  Cancel({
    this.person,
    this.reason,
    this.time,
    this.date,
  });

  factory Cancel.fromJson(Map<String, dynamic> json) => Cancel(
        person: json["person"],
        reason: json["reason"],
        time: json["time"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "person": person,
        "reason": reason,
        "time": time,
        "date": date,
      };
}

class Package {
  String? packageName;
  String? description;
  num? price;
  String? image;
  List<Service>? service;

  Package({this.packageName, this.description, this.price, this.image, this.service});

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageName: json["packageName"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
        service: json["service"] is List ? List<Service>.from(json["service"].map((x) => Service.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() => {
        "packageName": packageName,
        "description": description,
        "price": price,
        "image": image,
        "service": service == null ? [] : List<dynamic>.from(service!.map((x) => x.toJson())),
      };
}

class Service {
  String? name;
  String? image;
  num? price;
  String? id;

  Service({this.name, this.image, this.price, this.id});

  factory Service.fromJson(Map<String, dynamic> json) => Service(
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
