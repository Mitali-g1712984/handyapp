import 'dart:convert';

GetAgencyWiseProviderModel getAgencyWiseProviderModelFromJson(String str) =>
    GetAgencyWiseProviderModel.fromJson(json.decode(str));
String getAgencyWiseProviderModelToJson(GetAgencyWiseProviderModel data) => json.encode(data.toJson());

class GetAgencyWiseProviderModel {
  GetAgencyWiseProviderModel({
    bool? status,
    String? message,
    List<GetAgencyWiseProviders>? providers,
  }) {
    _status = status;
    _message = message;
    _providers = providers;
  }

  GetAgencyWiseProviderModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['providers'] != null) {
      _providers = [];
      json['providers'].forEach((v) {
        _providers?.add(GetAgencyWiseProviders.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GetAgencyWiseProviders>? _providers;
  GetAgencyWiseProviderModel copyWith({
    bool? status,
    String? message,
    List<GetAgencyWiseProviders>? providers,
  }) =>
      GetAgencyWiseProviderModel(
        status: status ?? _status,
        message: message ?? _message,
        providers: providers ?? _providers,
      );
  bool? get status => _status;
  String? get message => _message;
  List<GetAgencyWiseProviders>? get providers => _providers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_providers != null) {
      map['providers'] = _providers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

GetAgencyWiseProviders providersFromJson(String str) => GetAgencyWiseProviders.fromJson(json.decode(str));
String providersToJson(GetAgencyWiseProviders data) => json.encode(data.toJson());

class GetAgencyWiseProviders {
  GetAgencyWiseProviders({
    String? id,
    String? name,
    String? gender,
    String? mobileNumber,
    String? email,
    String? profileImage,
    String? yourSelf,
    String? serviceSummary,
    num? experience,
    List<String>? workHistory,
    Commission? commission,
    String? country,
    bool? isBlock,
    bool? isOnline,
  }) {
    _id = id;
    _name = name;
    _gender = gender;
    _mobileNumber = mobileNumber;
    _email = email;
    _profileImage = profileImage;
    _yourSelf = yourSelf;
    _serviceSummary = serviceSummary;
    _experience = experience;
    _workHistory = workHistory;
    _commission = commission;
    _country = country;
    _isBlock = isBlock;
    _isOnline = isOnline;
  }

  GetAgencyWiseProviders.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _gender = json['gender'];
    _mobileNumber = json['mobileNumber'];
    _email = json['email'];
    _profileImage = json['profileImage'];
    _yourSelf = json['yourSelf'];
    _serviceSummary = json['serviceSummary'];
    _experience = json['experience'];
    _workHistory = json['workHistory'] != null ? json['workHistory'].cast<String>() : [];
    _commission = json['commission'] != null ? Commission.fromJson(json['commission']) : null;
    _country = json['country'];
    _isBlock = json['isBlock'];
    _isOnline = json['isOnline'];
  }
  String? _id;
  String? _name;
  String? _gender;
  String? _mobileNumber;
  String? _email;
  String? _profileImage;
  String? _yourSelf;
  String? _serviceSummary;
  num? _experience;
  List<String>? _workHistory;
  Commission? _commission;
  String? _country;
  bool? _isBlock;
  bool? _isOnline;
  GetAgencyWiseProviders copyWith({
    String? id,
    String? name,
    String? gender,
    String? mobileNumber,
    String? email,
    String? profileImage,
    String? yourSelf,
    String? serviceSummary,
    num? experience,
    List<String>? workHistory,
    Commission? commission,
    String? country,
    bool? isBlock,
    bool? isOnline,
  }) =>
      GetAgencyWiseProviders(
        id: id ?? _id,
        name: name ?? _name,
        gender: gender ?? _gender,
        mobileNumber: mobileNumber ?? _mobileNumber,
        email: email ?? _email,
        profileImage: profileImage ?? _profileImage,
        yourSelf: yourSelf ?? _yourSelf,
        serviceSummary: serviceSummary ?? _serviceSummary,
        experience: experience ?? _experience,
        workHistory: workHistory ?? _workHistory,
        commission: commission ?? _commission,
        country: country ?? _country,
        isBlock: isBlock ?? _isBlock,
        isOnline: isOnline ?? _isOnline,
      );
  String? get id => _id;
  String? get name => _name;
  String? get gender => _gender;
  String? get mobileNumber => _mobileNumber;
  String? get email => _email;
  String? get profileImage => _profileImage;
  String? get yourSelf => _yourSelf;
  String? get serviceSummary => _serviceSummary;
  num? get experience => _experience;
  List<String>? get workHistory => _workHistory;
  Commission? get commission => _commission;
  String? get country => _country;
  bool? get isBlock => _isBlock;
  bool? get isOnline => _isOnline;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['gender'] = _gender;
    map['mobileNumber'] = _mobileNumber;
    map['email'] = _email;
    map['profileImage'] = _profileImage;
    map['yourSelf'] = _yourSelf;
    map['serviceSummary'] = _serviceSummary;
    map['experience'] = _experience;
    map['workHistory'] = _workHistory;
    if (_commission != null) {
      map['commission'] = _commission?.toJson();
    }
    map['country'] = _country;
    map['isBlock'] = _isBlock;
    map['isOnline'] = _isOnline;
    return map;
  }
}

Commission commissionFromJson(String str) => Commission.fromJson(json.decode(str));
String commissionToJson(Commission data) => json.encode(data.toJson());

class Commission {
  Commission({
    String? title,
    num? commission,
    num? commissionType,
    bool? isActive,
  }) {
    _title = title;
    _commission = commission;
    _commissionType = commissionType;
    _isActive = isActive;
  }

  Commission.fromJson(dynamic json) {
    _title = json['title'];
    _commission = json['commission'];
    _commissionType = json['commissionType'];
    _isActive = json['isActive'];
  }
  String? _title;
  num? _commission;
  num? _commissionType;
  bool? _isActive;
  Commission copyWith({
    String? title,
    num? commission,
    num? commissionType,
    bool? isActive,
  }) =>
      Commission(
        title: title ?? _title,
        commission: commission ?? _commission,
        commissionType: commissionType ?? _commissionType,
        isActive: isActive ?? _isActive,
      );
  String? get title => _title;
  num? get commission => _commission;
  num? get commissionType => _commissionType;
  bool? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['commission'] = _commission;
    map['commissionType'] = _commissionType;
    map['isActive'] = _isActive;
    return map;
  }
}
