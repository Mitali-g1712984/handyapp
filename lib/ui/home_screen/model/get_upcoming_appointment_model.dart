import 'dart:convert';

GetUpcomingAppointmentModel getUpcomingAppointmentModelFromJson(String str) =>
    GetUpcomingAppointmentModel.fromJson(json.decode(str));
String getUpcomingAppointmentModelToJson(GetUpcomingAppointmentModel data) => json.encode(data.toJson());

class GetUpcomingAppointmentModel {
  GetUpcomingAppointmentModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetUpcomingAppointmentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
  GetUpcomingAppointmentModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      GetUpcomingAppointmentModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    Coupon? coupon,
    Cancel? cancel,
    String? id,
    Customer? customer,
    String? agency,
    dynamic provider,
    Service? service,
    num? agencyApproval,
    num? status,
    String? appointmentId,
    String? serviceDetails,
    List<String>? image,
    String? time,
    num? duration,
    String? date,
    num? taxRate,
    num? taxAmount,
    num? discountAmount,
    num? serviceProviderFee,
    num? amountAfterTax,
    num? netPayableAmount,
    num? adminCommissionRate,
    num? adminCommissionAmount,
    num? agencyEarnings,
    num? agencyNetEarnings,
    num? providerNetEarnings,
    String? checkInTime,
    String? checkOutTime,
    bool? isReviewed,
    String? createdAt,
    String? updatedAt,
  }) {
    _coupon = coupon;
    _cancel = cancel;
    _id = id;
    _customer = customer;
    _agency = agency;
    _provider = provider;
    _service = service;
    _agencyApproval = agencyApproval;
    _status = status;
    _appointmentId = appointmentId;
    _serviceDetails = serviceDetails;
    _image = image;
    _time = time;
    _duration = duration;
    _date = date;
    _taxRate = taxRate;
    _taxAmount = taxAmount;
    _discountAmount = discountAmount;
    _serviceProviderFee = serviceProviderFee;
    _amountAfterTax = amountAfterTax;
    _netPayableAmount = netPayableAmount;
    _adminCommissionRate = adminCommissionRate;
    _adminCommissionAmount = adminCommissionAmount;
    _agencyEarnings = agencyEarnings;
    _agencyNetEarnings = agencyNetEarnings;
    _providerNetEarnings = providerNetEarnings;
    _checkInTime = checkInTime;
    _checkOutTime = checkOutTime;
    _isReviewed = isReviewed;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _coupon = json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null;
    _cancel = json['cancel'] != null ? Cancel.fromJson(json['cancel']) : null;
    _id = json['_id'];
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    _agency = json['agency'];
    _provider = json['provider'];
    _service = json['service'] != null ? Service.fromJson(json['service']) : null;
    _agencyApproval = json['agencyApproval'];
    _status = json['status'];
    _appointmentId = json['appointmentId'];
    _serviceDetails = json['serviceDetails'];
    _image = json['image'] != null ? json['image'].cast<String>() : [];
    _time = json['time'];
    _duration = json['duration'];
    _date = json['date'];
    _taxRate = json['taxRate'];
    _taxAmount = json['taxAmount'];
    _discountAmount = json['discountAmount'];
    _serviceProviderFee = json['serviceProviderFee'];
    _amountAfterTax = json['amountAfterTax'];
    _netPayableAmount = json['netPayableAmount'];
    _adminCommissionRate = json['adminCommissionRate'];
    _adminCommissionAmount = json['adminCommissionAmount'];
    _agencyEarnings = json['agencyEarnings'];
    _agencyNetEarnings = json['agencyNetEarnings'];
    _providerNetEarnings = json['providerNetEarnings'];
    _checkInTime = json['checkInTime'];
    _checkOutTime = json['checkOutTime'];
    _isReviewed = json['isReviewed'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  Coupon? _coupon;
  Cancel? _cancel;
  String? _id;
  Customer? _customer;
  String? _agency;
  dynamic _provider;
  Service? _service;
  num? _agencyApproval;
  num? _status;
  String? _appointmentId;
  String? _serviceDetails;
  List<String>? _image;
  String? _time;
  num? _duration;
  String? _date;
  num? _taxRate;
  num? _taxAmount;
  num? _discountAmount;
  num? _serviceProviderFee;
  num? _amountAfterTax;
  num? _netPayableAmount;
  num? _adminCommissionRate;
  num? _adminCommissionAmount;
  num? _agencyEarnings;
  num? _agencyNetEarnings;
  num? _providerNetEarnings;
  String? _checkInTime;
  String? _checkOutTime;
  bool? _isReviewed;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    Coupon? coupon,
    Cancel? cancel,
    String? id,
    Customer? customer,
    String? agency,
    dynamic provider,
    Service? service,
    num? agencyApproval,
    num? status,
    String? appointmentId,
    String? serviceDetails,
    List<String>? image,
    String? time,
    num? duration,
    String? date,
    num? taxRate,
    num? taxAmount,
    num? discountAmount,
    num? serviceProviderFee,
    num? amountAfterTax,
    num? netPayableAmount,
    num? adminCommissionRate,
    num? adminCommissionAmount,
    num? agencyEarnings,
    num? agencyNetEarnings,
    num? providerNetEarnings,
    String? checkInTime,
    String? checkOutTime,
    bool? isReviewed,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        coupon: coupon ?? _coupon,
        cancel: cancel ?? _cancel,
        id: id ?? _id,
        customer: customer ?? _customer,
        agency: agency ?? _agency,
        provider: provider ?? _provider,
        service: service ?? _service,
        agencyApproval: agencyApproval ?? _agencyApproval,
        status: status ?? _status,
        appointmentId: appointmentId ?? _appointmentId,
        serviceDetails: serviceDetails ?? _serviceDetails,
        image: image ?? _image,
        time: time ?? _time,
        duration: duration ?? _duration,
        date: date ?? _date,
        taxRate: taxRate ?? _taxRate,
        taxAmount: taxAmount ?? _taxAmount,
        discountAmount: discountAmount ?? _discountAmount,
        serviceProviderFee: serviceProviderFee ?? _serviceProviderFee,
        amountAfterTax: amountAfterTax ?? _amountAfterTax,
        netPayableAmount: netPayableAmount ?? _netPayableAmount,
        adminCommissionRate: adminCommissionRate ?? _adminCommissionRate,
        adminCommissionAmount: adminCommissionAmount ?? _adminCommissionAmount,
        agencyEarnings: agencyEarnings ?? _agencyEarnings,
        agencyNetEarnings: agencyNetEarnings ?? _agencyNetEarnings,
        providerNetEarnings: providerNetEarnings ?? _providerNetEarnings,
        checkInTime: checkInTime ?? _checkInTime,
        checkOutTime: checkOutTime ?? _checkOutTime,
        isReviewed: isReviewed ?? _isReviewed,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  Coupon? get coupon => _coupon;
  Cancel? get cancel => _cancel;
  String? get id => _id;
  Customer? get customer => _customer;
  String? get agency => _agency;
  dynamic get provider => _provider;
  Service? get service => _service;
  num? get agencyApproval => _agencyApproval;
  num? get status => _status;
  String? get appointmentId => _appointmentId;
  String? get serviceDetails => _serviceDetails;
  List<String>? get image => _image;
  String? get time => _time;
  num? get duration => _duration;
  String? get date => _date;
  num? get taxRate => _taxRate;
  num? get taxAmount => _taxAmount;
  num? get discountAmount => _discountAmount;
  num? get serviceProviderFee => _serviceProviderFee;
  num? get amountAfterTax => _amountAfterTax;
  num? get netPayableAmount => _netPayableAmount;
  num? get adminCommissionRate => _adminCommissionRate;
  num? get adminCommissionAmount => _adminCommissionAmount;
  num? get agencyEarnings => _agencyEarnings;
  num? get agencyNetEarnings => _agencyNetEarnings;
  num? get providerNetEarnings => _providerNetEarnings;
  String? get checkInTime => _checkInTime;
  String? get checkOutTime => _checkOutTime;
  bool? get isReviewed => _isReviewed;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_coupon != null) {
      map['coupon'] = _coupon?.toJson();
    }
    if (_cancel != null) {
      map['cancel'] = _cancel?.toJson();
    }
    map['_id'] = _id;
    if (_customer != null) {
      map['customer'] = _customer?.toJson();
    }
    map['agency'] = _agency;
    map['provider'] = _provider;
    if (_service != null) {
      map['service'] = _service?.toJson();
    }
    map['agencyApproval'] = _agencyApproval;
    map['status'] = _status;
    map['appointmentId'] = _appointmentId;
    map['serviceDetails'] = _serviceDetails;
    map['image'] = _image;
    map['time'] = _time;
    map['duration'] = _duration;
    map['date'] = _date;
    map['taxRate'] = _taxRate;
    map['taxAmount'] = _taxAmount;
    map['discountAmount'] = _discountAmount;
    map['serviceProviderFee'] = _serviceProviderFee;
    map['amountAfterTax'] = _amountAfterTax;
    map['netPayableAmount'] = _netPayableAmount;
    map['adminCommissionRate'] = _adminCommissionRate;
    map['adminCommissionAmount'] = _adminCommissionAmount;
    map['agencyEarnings'] = _agencyEarnings;
    map['agencyNetEarnings'] = _agencyNetEarnings;
    map['providerNetEarnings'] = _providerNetEarnings;
    map['checkInTime'] = _checkInTime;
    map['checkOutTime'] = _checkOutTime;
    map['isReviewed'] = _isReviewed;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));
String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
    String? id,
    String? name,
    String? image,
  }) {
    _id = id;
    _name = name;
    _image = image;
  }

  Service.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _image = json['image'];
  }
  String? _id;
  String? _name;
  String? _image;
  Service copyWith({
    String? id,
    String? name,
    String? image,
  }) =>
      Service(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
      );
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
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
  }) {
    _id = id;
    _name = name;
    _profileImage = profileImage;
  }

  Customer.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _profileImage = json['profileImage'];
  }
  String? _id;
  String? _name;
  String? _profileImage;
  Customer copyWith({
    String? id,
    String? name,
    String? profileImage,
  }) =>
      Customer(
        id: id ?? _id,
        name: name ?? _name,
        profileImage: profileImage ?? _profileImage,
      );
  String? get id => _id;
  String? get name => _name;
  String? get profileImage => _profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['profileImage'] = _profileImage;
    return map;
  }
}

Cancel cancelFromJson(String str) => Cancel.fromJson(json.decode(str));
String cancelToJson(Cancel data) => json.encode(data.toJson());

class Cancel {
  Cancel({
    String? reason,
  }) {
    _reason = reason;
  }

  Cancel.fromJson(dynamic json) {
    _reason = json['reason'];
  }
  String? _reason;
  Cancel copyWith({
    String? reason,
  }) =>
      Cancel(
        reason: reason ?? _reason,
      );
  String? get reason => _reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reason'] = _reason;
    return map;
  }
}

Coupon couponFromJson(String str) => Coupon.fromJson(json.decode(str));
String couponToJson(Coupon data) => json.encode(data.toJson());

class Coupon {
  Coupon({
    String? title,
    String? description,
    dynamic code,
    dynamic discountType,
    dynamic maxDiscount,
    num? minAmountToApply,
  }) {
    _title = title;
    _description = description;
    _code = code;
    _discountType = discountType;
    _maxDiscount = maxDiscount;
    _minAmountToApply = minAmountToApply;
  }

  Coupon.fromJson(dynamic json) {
    _title = json['title'];
    _description = json['description'];
    _code = json['code'];
    _discountType = json['discountType'];
    _maxDiscount = json['maxDiscount'];
    _minAmountToApply = json['minAmountToApply'];
  }
  String? _title;
  String? _description;
  dynamic _code;
  dynamic _discountType;
  dynamic _maxDiscount;
  num? _minAmountToApply;
  Coupon copyWith({
    String? title,
    String? description,
    dynamic code,
    dynamic discountType,
    dynamic maxDiscount,
    num? minAmountToApply,
  }) =>
      Coupon(
        title: title ?? _title,
        description: description ?? _description,
        code: code ?? _code,
        discountType: discountType ?? _discountType,
        maxDiscount: maxDiscount ?? _maxDiscount,
        minAmountToApply: minAmountToApply ?? _minAmountToApply,
      );
  String? get title => _title;
  String? get description => _description;
  dynamic get code => _code;
  dynamic get discountType => _discountType;
  dynamic get maxDiscount => _maxDiscount;
  num? get minAmountToApply => _minAmountToApply;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['description'] = _description;
    map['code'] = _code;
    map['discountType'] = _discountType;
    map['maxDiscount'] = _maxDiscount;
    map['minAmountToApply'] = _minAmountToApply;
    return map;
  }
}
