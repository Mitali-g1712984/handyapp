import 'dart:convert';

SetPasswordModel setPasswordModelFromJson(String str) => SetPasswordModel.fromJson(json.decode(str));
String setPasswordModelToJson(SetPasswordModel data) => json.encode(data.toJson());

class SetPasswordModel {
  SetPasswordModel({
    bool? status,
    String? message,
    Customer? customer,
  }) {
    _status = status;
    _message = message;
    _customer = customer;
  }

  SetPasswordModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }
  bool? _status;
  String? _message;
  Customer? _customer;
  SetPasswordModel copyWith({
    bool? status,
    String? message,
    Customer? customer,
  }) =>
      SetPasswordModel(
        status: status ?? _status,
        message: message ?? _message,
        customer: customer ?? _customer,
      );
  bool? get status => _status;
  String? get message => _message;
  Customer? get customer => _customer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_customer != null) {
      map['customer'] = _customer?.toJson();
    }
    return map;
  }
}

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));
String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    String? id,
    String? name,
    String? profileImage,
    String? gender,
    String? bio,
    num? age,
    String? email,
    String? password,
    String? mobileNumber,
    String? identity,
    String? fcmToken,
    String? uniqueId,
    String? country,
    String? latitude,
    String? longitude,
    String? ipAddress,
    String? date,
    String? lastlogin,
    bool? isBlock,
    bool? isActive,
    num? amount,
    bool? isOnline,
    bool? isBusy,
    dynamic callId,
    num? loginType,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _profileImage = profileImage;
    _gender = gender;
    _bio = bio;
    _age = age;
    _email = email;
    _password = password;
    _mobileNumber = mobileNumber;
    _identity = identity;
    _fcmToken = fcmToken;
    _uniqueId = uniqueId;
    _country = country;
    _latitude = latitude;
    _longitude = longitude;
    _ipAddress = ipAddress;
    _date = date;
    _lastlogin = lastlogin;
    _isBlock = isBlock;
    _isActive = isActive;
    _amount = amount;
    _isOnline = isOnline;
    _isBusy = isBusy;
    _callId = callId;
    _loginType = loginType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Customer.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _profileImage = json['profileImage'];
    _gender = json['gender'];
    _bio = json['bio'];
    _age = json['age'];
    _email = json['email'];
    _password = json['password'];
    _mobileNumber = json['mobileNumber'];
    _identity = json['identity'];
    _fcmToken = json['fcmToken'];
    _uniqueId = json['uniqueId'];
    _country = json['country'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _ipAddress = json['ipAddress'];
    _date = json['date'];
    _lastlogin = json['lastlogin'];
    _isBlock = json['isBlock'];
    _isActive = json['isActive'];
    _amount = json['amount'];
    _isOnline = json['isOnline'];
    _isBusy = json['isBusy'];
    _callId = json['callId'];
    _loginType = json['loginType'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _name;
  String? _profileImage;
  String? _gender;
  String? _bio;
  num? _age;
  String? _email;
  String? _password;
  String? _mobileNumber;
  String? _identity;
  String? _fcmToken;
  String? _uniqueId;
  String? _country;
  String? _latitude;
  String? _longitude;
  String? _ipAddress;
  String? _date;
  String? _lastlogin;
  bool? _isBlock;
  bool? _isActive;
  num? _amount;
  bool? _isOnline;
  bool? _isBusy;
  dynamic _callId;
  num? _loginType;
  String? _createdAt;
  String? _updatedAt;
  Customer copyWith({
    String? id,
    String? name,
    String? profileImage,
    String? gender,
    String? bio,
    num? age,
    String? email,
    String? password,
    String? mobileNumber,
    String? identity,
    String? fcmToken,
    String? uniqueId,
    String? country,
    String? latitude,
    String? longitude,
    String? ipAddress,
    String? date,
    String? lastlogin,
    bool? isBlock,
    bool? isActive,
    num? amount,
    bool? isOnline,
    bool? isBusy,
    dynamic callId,
    num? loginType,
    String? createdAt,
    String? updatedAt,
  }) =>
      Customer(
        id: id ?? _id,
        name: name ?? _name,
        profileImage: profileImage ?? _profileImage,
        gender: gender ?? _gender,
        bio: bio ?? _bio,
        age: age ?? _age,
        email: email ?? _email,
        password: password ?? _password,
        mobileNumber: mobileNumber ?? _mobileNumber,
        identity: identity ?? _identity,
        fcmToken: fcmToken ?? _fcmToken,
        uniqueId: uniqueId ?? _uniqueId,
        country: country ?? _country,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        ipAddress: ipAddress ?? _ipAddress,
        date: date ?? _date,
        lastlogin: lastlogin ?? _lastlogin,
        isBlock: isBlock ?? _isBlock,
        isActive: isActive ?? _isActive,
        amount: amount ?? _amount,
        isOnline: isOnline ?? _isOnline,
        isBusy: isBusy ?? _isBusy,
        callId: callId ?? _callId,
        loginType: loginType ?? _loginType,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get name => _name;
  String? get profileImage => _profileImage;
  String? get gender => _gender;
  String? get bio => _bio;
  num? get age => _age;
  String? get email => _email;
  String? get password => _password;
  String? get mobileNumber => _mobileNumber;
  String? get identity => _identity;
  String? get fcmToken => _fcmToken;
  String? get uniqueId => _uniqueId;
  String? get country => _country;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get ipAddress => _ipAddress;
  String? get date => _date;
  String? get lastlogin => _lastlogin;
  bool? get isBlock => _isBlock;
  bool? get isActive => _isActive;
  num? get amount => _amount;
  bool? get isOnline => _isOnline;
  bool? get isBusy => _isBusy;
  dynamic get callId => _callId;
  num? get loginType => _loginType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['profileImage'] = _profileImage;
    map['gender'] = _gender;
    map['bio'] = _bio;
    map['age'] = _age;
    map['email'] = _email;
    map['password'] = _password;
    map['mobileNumber'] = _mobileNumber;
    map['identity'] = _identity;
    map['fcmToken'] = _fcmToken;
    map['uniqueId'] = _uniqueId;
    map['country'] = _country;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['ipAddress'] = _ipAddress;
    map['date'] = _date;
    map['lastlogin'] = _lastlogin;
    map['isBlock'] = _isBlock;
    map['isActive'] = _isActive;
    map['amount'] = _amount;
    map['isOnline'] = _isOnline;
    map['isBusy'] = _isBusy;
    map['callId'] = _callId;
    map['loginType'] = _loginType;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
