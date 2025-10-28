// To parse this JSON data, do
//
//     final getSettingModel = getSettingModelFromJson(jsonString);

import 'dart:convert';

GetSettingModel getSettingModelFromJson(String str) => GetSettingModel.fromJson(json.decode(str));

String getSettingModelToJson(GetSettingModel data) => json.encode(data.toJson());

class GetSettingModel {
  bool? status;
  String? message;
  Data? data;

  GetSettingModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetSettingModel.fromJson(Map<String, dynamic> json) => GetSettingModel(
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
  Currency? currency;
  String? id;
  String? stripePublishableKey;
  String? stripeSecretKey;
  String? razorPayId;
  String? razorSecretKey;
  bool? isFlutterWave;
  String? flutterWaveKey;
  String? privacyPolicyLink;
  String? termsOfUsePolicyLink;
  String? zegoAppId;
  String? zegoAppSignIn;
  List<dynamic>? paymentGateway;
  bool? isUnderMaintenance;
  int? taxRate;
  int? adminCommissionRate;
  int? minWithdrawalRequestedAmount;
  PrivateKey? privateKey;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isGooglePlay;
  bool? isRazorPay;
  bool? isStripe;

  Data({
    this.currency,
    this.id,
    this.stripePublishableKey,
    this.stripeSecretKey,
    this.razorPayId,
    this.razorSecretKey,
    this.isFlutterWave,
    this.flutterWaveKey,
    this.privacyPolicyLink,
    this.termsOfUsePolicyLink,
    this.zegoAppId,
    this.zegoAppSignIn,
    this.paymentGateway,
    this.isUnderMaintenance,
    this.taxRate,
    this.adminCommissionRate,
    this.minWithdrawalRequestedAmount,
    this.privateKey,
    this.createdAt,
    this.updatedAt,
    this.isGooglePlay,
    this.isRazorPay,
    this.isStripe,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
        id: json["_id"],
        stripePublishableKey: json["stripePublishableKey"],
        stripeSecretKey: json["stripeSecretKey"],
        razorPayId: json["razorPayId"],
        razorSecretKey: json["razorSecretKey"],
        isFlutterWave: json["isFlutterWave"],
        flutterWaveKey: json["flutterWaveKey"],
        privacyPolicyLink: json["privacyPolicyLink"],
        termsOfUsePolicyLink: json["termsOfUsePolicyLink"],
        zegoAppId: json["zegoAppId"],
        zegoAppSignIn: json["zegoAppSignIn"],
        paymentGateway: json["paymentGateway"] == null ? [] : List<dynamic>.from(json["paymentGateway"]!.map((x) => x)),
        isUnderMaintenance: json["isUnderMaintenance"],
        taxRate: json["taxRate"],
        adminCommissionRate: json["adminCommissionRate"],
        minWithdrawalRequestedAmount: json["minWithdrawalRequestedAmount"],
        privateKey: json["privateKey"] == null ? null : PrivateKey.fromJson(json["privateKey"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        isGooglePlay: json["isGooglePlay"],
        isRazorPay: json["isRazorPay"],
        isStripe: json["isStripe"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency?.toJson(),
        "_id": id,
        "stripePublishableKey": stripePublishableKey,
        "stripeSecretKey": stripeSecretKey,
        "razorPayId": razorPayId,
        "razorSecretKey": razorSecretKey,
        "isFlutterWave": isFlutterWave,
        "flutterWaveKey": flutterWaveKey,
        "privacyPolicyLink": privacyPolicyLink,
        "termsOfUsePolicyLink": termsOfUsePolicyLink,
        "zegoAppId": zegoAppId,
        "zegoAppSignIn": zegoAppSignIn,
        "paymentGateway": paymentGateway == null ? [] : List<dynamic>.from(paymentGateway!.map((x) => x)),
        "isUnderMaintenance": isUnderMaintenance,
        "taxRate": taxRate,
        "adminCommissionRate": adminCommissionRate,
        "minWithdrawalRequestedAmount": minWithdrawalRequestedAmount,
        "privateKey": privateKey?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "isGooglePlay": isGooglePlay,
        "isRazorPay": isRazorPay,
        "isStripe": isStripe,
      };
}

class Currency {
  String? name;
  String? symbol;
  String? countryCode;
  String? currencyCode;
  bool? isDefault;

  Currency({
    this.name,
    this.symbol,
    this.countryCode,
    this.currencyCode,
    this.isDefault,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        symbol: json["symbol"],
        countryCode: json["countryCode"],
        currencyCode: json["currencyCode"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
        "countryCode": countryCode,
        "currencyCode": currencyCode,
        "isDefault": isDefault,
      };
}

class PrivateKey {
  String? type;
  String? projectId;
  String? privateKeyId;
  String? privateKey;
  String? clientEmail;
  String? clientId;
  String? authUri;
  String? tokenUri;
  String? authProviderX509CertUrl;
  String? clientX509CertUrl;
  String? universeDomain;

  PrivateKey({
    this.type,
    this.projectId,
    this.privateKeyId,
    this.privateKey,
    this.clientEmail,
    this.clientId,
    this.authUri,
    this.tokenUri,
    this.authProviderX509CertUrl,
    this.clientX509CertUrl,
    this.universeDomain,
  });

  factory PrivateKey.fromJson(Map<String, dynamic> json) => PrivateKey(
        type: json["type"],
        projectId: json["project_id"],
        privateKeyId: json["private_key_id"],
        privateKey: json["private_key"],
        clientEmail: json["client_email"],
        clientId: json["client_id"],
        authUri: json["auth_uri"],
        tokenUri: json["token_uri"],
        authProviderX509CertUrl: json["auth_provider_x509_cert_url"],
        clientX509CertUrl: json["client_x509_cert_url"],
        universeDomain: json["universe_domain"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "project_id": projectId,
        "private_key_id": privateKeyId,
        "private_key": privateKey,
        "client_email": clientEmail,
        "client_id": clientId,
        "auth_uri": authUri,
        "token_uri": tokenUri,
        "auth_provider_x509_cert_url": authProviderX509CertUrl,
        "client_x509_cert_url": clientX509CertUrl,
        "universe_domain": universeDomain,
      };
}
