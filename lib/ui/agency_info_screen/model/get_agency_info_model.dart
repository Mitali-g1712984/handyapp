// To parse this JSON data, do
//
//     final getAgencyInfoModel = getAgencyInfoModelFromJson(jsonString);

import 'dart:convert';

GetAgencyInfoModel getAgencyInfoModelFromJson(String str) => GetAgencyInfoModel.fromJson(json.decode(str));

String getAgencyInfoModelToJson(GetAgencyInfoModel data) => json.encode(data.toJson());

class GetAgencyInfoModel {
  bool? status;
  String? message;
  AgencyInfo? agencyInfo;

  GetAgencyInfoModel({
    this.status,
    this.message,
    this.agencyInfo,
  });

  factory GetAgencyInfoModel.fromJson(Map<String, dynamic> json) => GetAgencyInfoModel(
        status: json["status"],
        message: json["message"],
        agencyInfo: json["agencyInfo"] == null ? null : AgencyInfo.fromJson(json["agencyInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "agencyInfo": agencyInfo?.toJson(),
      };
}

class AgencyInfo {
  String? id;
  Commission? commission;
  String? firstName;
  String? lastName;
  String? userName;
  String? mobileNumber;
  String? email;
  String? profileImage;
  List<String>? language;
  List<String>? expertise;
  String? designation;
  String? yourSelf;
  String? country;
  num? reviewCount;
  num? avgRating;
  List<AgencyInfoService>? service;
  bool? isFavorite;
  num? totalAgencyUnderPro;
  num? totalCustomers;
  num? taxRate;
  List<MatchingPackage>? matchingPackages;

  AgencyInfo({
    this.id,
    this.commission,
    this.firstName,
    this.lastName,
    this.userName,
    this.mobileNumber,
    this.email,
    this.profileImage,
    this.language,
    this.expertise,
    this.designation,
    this.yourSelf,
    this.country,
    this.reviewCount,
    this.avgRating,
    this.service,
    this.isFavorite,
    this.totalAgencyUnderPro,
    this.totalCustomers,
    this.taxRate,
    this.matchingPackages,
  });

  factory AgencyInfo.fromJson(Map<String, dynamic> json) => AgencyInfo(
        id: json["_id"],
        commission: json["commission"] == null ? null : Commission.fromJson(json["commission"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        profileImage: json["profileImage"],
        language: json["language"] == null ? [] : List<String>.from(json["language"]!.map((x) => x)),
        expertise: json["expertise"] == null ? [] : List<String>.from(json["expertise"]!.map((x) => x)),
        designation: json["designation"],
        yourSelf: json["yourSelf"],
        country: json["country"],
        reviewCount: json["reviewCount"],
        avgRating: json["avgRating"],
        service: json["service"] == null
            ? []
            : List<AgencyInfoService>.from(json["service"]!.map((x) => AgencyInfoService.fromJson(x))),
        isFavorite: json["isFavorite"],
        totalAgencyUnderPro: json["totalAgencyUnderPro"],
        totalCustomers: json["totalCustomers"],
        taxRate: json["taxRate"],
        matchingPackages: json["matchingPackages"] == null
            ? []
            : List<MatchingPackage>.from(json["matchingPackages"]!.map((x) => MatchingPackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "commission": commission?.toJson(),
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "mobileNumber": mobileNumber,
        "email": email,
        "profileImage": profileImage,
        "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
        "expertise": expertise == null ? [] : List<dynamic>.from(expertise!.map((x) => x)),
        "designation": designation,
        "yourSelf": yourSelf,
        "country": country,
        "reviewCount": reviewCount,
        "avgRating": avgRating,
        "service": service == null ? [] : List<dynamic>.from(service!.map((x) => x.toJson())),
        "isFavorite": isFavorite,
        "totalAgencyUnderPro": totalAgencyUnderPro,
        "totalCustomers": totalCustomers,
        "taxRate": taxRate,
        "matchingPackages": matchingPackages == null ? [] : List<dynamic>.from(matchingPackages!.map((x) => x.toJson())),
      };
}

class Commission {
  String? title;
  num? commission;
  num? commissionType;
  bool? isActive;

  Commission({
    this.title,
    this.commission,
    this.commissionType,
    this.isActive,
  });

  factory Commission.fromJson(Map<String, dynamic> json) => Commission(
        title: json["title"],
        commission: json["commission"],
        commissionType: json["commissionType"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "commission": commission,
        "commissionType": commissionType,
        "isActive": isActive,
      };
}

class MatchingPackage {
  String? id;
  String? packageName;
  String? description;
  num? price;
  List<MatchingPackageService>? service;
  String? image;
  num? listedPrice;

  MatchingPackage({
    this.id,
    this.packageName,
    this.description,
    this.price,
    this.service,
    this.image,
    this.listedPrice,
  });

  factory MatchingPackage.fromJson(Map<String, dynamic> json) => MatchingPackage(
        id: json["_id"],
        packageName: json["packageName"],
        description: json["description"],
        price: json["price"],
        service: json["service"] == null
            ? []
            : List<MatchingPackageService>.from(json["service"]!.map((x) => MatchingPackageService.fromJson(x))),
        image: json["image"],
        listedPrice: json["listedPrice"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "packageName": packageName,
        "description": description,
        "price": price,
        "service": service == null ? [] : List<dynamic>.from(service!.map((x) => x.toJson())),
        "image": image,
        "listedPrice": listedPrice,
      };
}

class MatchingPackageService {
  String? serviceId;
  String? name;
  String? image;
  num? price;
  String? id;

  MatchingPackageService({
    this.serviceId,
    this.name,
    this.image,
    this.price,
    this.id,
  });

  factory MatchingPackageService.fromJson(Map<String, dynamic> json) => MatchingPackageService(
        serviceId: json["serviceId"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "name": name,
        "image": image,
        "price": price,
        "_id": id,
      };
}

class AgencyInfoService {
  String? serviceId;
  String? name;
  String? image;
  bool? isActive;
  num? price;
  num? duration;
  num? blockSize;
  num? avgRating;
  num? reviewCount;
  String? id;

  AgencyInfoService({
    this.serviceId,
    this.name,
    this.image,
    this.isActive,
    this.price,
    this.duration,
    this.blockSize,
    this.avgRating,
    this.reviewCount,
    this.id,
  });

  factory AgencyInfoService.fromJson(Map<String, dynamic> json) => AgencyInfoService(
        serviceId: json["serviceId"],
        name: json["name"],
        image: json["image"],
        isActive: json["isActive"],
        price: json["price"],
        duration: json["duration"],
        blockSize: json["blockSize"],
        avgRating: json["avgRating"],
        reviewCount: json["reviewCount"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "name": name,
        "image": image,
        "isActive": isActive,
        "price": price,
        "duration": duration,
        "blockSize": blockSize,
        "avgRating": avgRating,
        "reviewCount": reviewCount,
        "_id": id,
      };
}
