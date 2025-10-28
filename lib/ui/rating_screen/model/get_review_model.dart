import 'dart:convert';

GetReviewModel getReviewModelFromJson(String str) => GetReviewModel.fromJson(json.decode(str));
String getReviewModelToJson(GetReviewModel data) => json.encode(data.toJson());

class GetReviewModel {
  GetReviewModel({
    bool? status,
    String? message,
    List<ReviewsOfProvider>? reviewsOfProvider,
  }) {
    _status = status;
    _message = message;
    _reviewsOfProvider = reviewsOfProvider;
  }

  GetReviewModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['reviewsOfProvider'] != null) {
      _reviewsOfProvider = [];
      json['reviewsOfProvider'].forEach((v) {
        _reviewsOfProvider?.add(ReviewsOfProvider.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ReviewsOfProvider>? _reviewsOfProvider;
  GetReviewModel copyWith({
    bool? status,
    String? message,
    List<ReviewsOfProvider>? reviewsOfProvider,
  }) =>
      GetReviewModel(
        status: status ?? _status,
        message: message ?? _message,
        reviewsOfProvider: reviewsOfProvider ?? _reviewsOfProvider,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ReviewsOfProvider>? get reviewsOfProvider => _reviewsOfProvider;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_reviewsOfProvider != null) {
      map['reviewsOfProvider'] = _reviewsOfProvider?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

ReviewsOfProvider reviewsOfProviderFromJson(String str) => ReviewsOfProvider.fromJson(json.decode(str));
String reviewsOfProviderToJson(ReviewsOfProvider data) => json.encode(data.toJson());

class ReviewsOfProvider {
  ReviewsOfProvider({
    String? id,
    String? review,
    num? rating,
    String? name,
    String? profileImage,
    String? time,
  }) {
    _id = id;
    _review = review;
    _rating = rating;
    _name = name;
    _profileImage = profileImage;
    _time = time;
  }

  ReviewsOfProvider.fromJson(dynamic json) {
    _id = json['_id'];
    _review = json['review'];
    _rating = json['rating'];
    _name = json['name'];
    _profileImage = json['profileImage'];
    _time = json['time'];
  }
  String? _id;
  String? _review;
  num? _rating;
  String? _name;
  String? _profileImage;
  String? _time;
  ReviewsOfProvider copyWith({
    String? id,
    String? review,
    num? rating,
    String? name,
    String? profileImage,
    String? time,
  }) =>
      ReviewsOfProvider(
        id: id ?? _id,
        review: review ?? _review,
        rating: rating ?? _rating,
        name: name ?? _name,
        profileImage: profileImage ?? _profileImage,
        time: time ?? _time,
      );
  String? get id => _id;
  String? get review => _review;
  num? get rating => _rating;
  String? get name => _name;
  String? get profileImage => _profileImage;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['review'] = _review;
    map['rating'] = _rating;
    map['name'] = _name;
    map['profileImage'] = _profileImage;
    map['time'] = _time;
    return map;
  }
}
