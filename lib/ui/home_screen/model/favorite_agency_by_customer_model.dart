import 'dart:convert';

FavoriteAgencyByCustomerModel favoriteAgencyByCustomerModelFromJson(String str) =>
    FavoriteAgencyByCustomerModel.fromJson(json.decode(str));
String favoriteAgencyByCustomerModelToJson(FavoriteAgencyByCustomerModel data) => json.encode(data.toJson());

class FavoriteAgencyByCustomerModel {
  FavoriteAgencyByCustomerModel({
    bool? status,
    String? message,
    bool? isFavorite,
  }) {
    _status = status;
    _message = message;
    _isFavorite = isFavorite;
  }

  FavoriteAgencyByCustomerModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _isFavorite = json['isFavorite'];
  }
  bool? _status;
  String? _message;
  bool? _isFavorite;
  FavoriteAgencyByCustomerModel copyWith({
    bool? status,
    String? message,
    bool? isFavorite,
  }) =>
      FavoriteAgencyByCustomerModel(
        status: status ?? _status,
        message: message ?? _message,
        isFavorite: isFavorite ?? _isFavorite,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get isFavorite => _isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['isFavorite'] = _isFavorite;
    return map;
  }
}
