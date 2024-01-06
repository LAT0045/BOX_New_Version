import 'package:box/class/food.dart';

class Order{
  late String _orderId;
  late String _address;
  late String _dateScheduled;
  late List<Food> _foods;
  late bool _isScheduled;
  late String _name;
  late String _paymentMethod;
  late String _shopId;
  late String _status;
  late String _timeScheduled;
  late String _userId; 
  late String _phoneNumber;
  late int _shippingFee;
  late int _discount; 

  Order(
    this._orderId,
    this._address,
    this._dateScheduled,
    this._foods,
    this._isScheduled,
    this._name,
    this._paymentMethod,
    this._phoneNumber,
    this._shopId,
    this._status,
    this._timeScheduled,
    this._userId,
    this._shippingFee,
    this._discount,
    
  );

  Order.empty() 
    :_orderId = '',
    _address = '',
    _dateScheduled = '',
    _foods = [],
    _isScheduled = false,
    _name ='',
    _paymentMethod = '',
    _phoneNumber ='',
    _shopId = '',
    _status = '',
    _timeScheduled = '',
    _userId = '';

    
  factory Order.fromJson(String orderId, Map<String, dynamic> json) {
    final List<Food> foods = json['foods'] != null
        ? List<Food>.from(json['foods'].asMap().entries.map((entry) =>
            Food.fromJson(entry.key.toString(),
                Map<String, dynamic>.from(entry.value as Map))))
        : [];

    return Order(
      orderId,
      json['address'] ?? '',
      json['dateScheduled'] ?? '',
      foods,
      json['isScheduled'] ?? false,
      json['name'] ?? '',
      json['paymentMethod'] ?? '',
      json['phoneNumber'] ?? '',
      json['shopId'] ?? '',
      json['status'] ?? '',
      json['timeScheduled'] ?? '',
      json['userId'] ?? '',
      json['shippingFee'] ?? 0,
      json['discount'] ?? 0,
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'orderId': _orderId,
      'address': _address,
      'dateScheduled': _dateScheduled,
      'foods':  _foods,
      'isScheduled': _isScheduled,
      'name': _name,
      'shopId': _shopId,
      'phoneNumber': _phoneNumber,
      'paymentMethod': _paymentMethod,
      'status': _status,
      'timeScheduled': _timeScheduled,
      'userId': _userId,
      'shippingFee': _shippingFee,
      'discount': _discount,

    };
  }

  String get orderId {
    return _orderId;
  }

  String get address {
    return _address;
  }

  String get dateScheduled {
    return _dateScheduled;
  }

  String get name {
    return _name;
  }

  String get paymentMethod {
    return _paymentMethod;
  }

  String get shopId {
    return _shopId;
  }

  String get status {
    return _status;
  }

  List<Food> get foods {
    return _foods;
  }

  set foods(List<Food> values) {
    _foods = values;
  }

  bool get isScheduled {
    return _isScheduled;
  }

  String get timeScheduled {
    return _timeScheduled;
  }

  String get userId {
    return _userId;
  }

  String get phoneNumber {
    return _phoneNumber;
  }

  int get shippingFee {
    return _shippingFee;
  }

  int get discount {
    return _discount;
  }

  

}