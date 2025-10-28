import 'dart:convert';

PostReviewModel postReviewModelFromJson(String str) => PostReviewModel.fromJson(json.decode(str));
String postReviewModelToJson(PostReviewModel data) => json.encode(data.toJson());

class PostReviewModel {
  PostReviewModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  PostReviewModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  PostReviewModel copyWith({
    bool? status,
    String? message,
  }) =>
      PostReviewModel(
        status: status ?? _status,
        message: message ?? _message,
      );
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
