import 'dart:convert';

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

  Order(
    this._orderId,
    this._address,
    this._dateScheduled,
    this._foods,
    this._isScheduled,
    this._name,
    this._paymentMethod,
    this._shopId,
    this._status,
    this._timeScheduled,
    this._userId
  );

  Order.empty() 
      :_orderId = '',
      _address = '',
      _dateScheduled = '',
      _name ='',
      _paymentMethod = '',
      _foods = [],
      _shopId = '',
      _status = '',
      _isScheduled = false,
      _timeScheduled = '',
      _userId = '';

    
  factory Order.fromJson(String orderId, Map<String, dynamic> json) {
    final List<dynamic> foodJsonList = json['foods'] ?? [];
    final List<Food> foods = foodJsonList.isNotEmpty
        ? foodJsonList.map((food) => Food.fromJson('', food)).toList()
        : [];

    return Order(
      orderId,
      json['address'] ?? '',
      json['dateScheduled'] ?? '',
      foods,
      json['isScheduled'] ?? false,
      json['name'] ?? '',
      json['paymentMethod'] ?? '',
      json['shopId'] ?? '',
      json['status'] ?? '',
      json['timeScheduled'] ?? '',
      json['userId'] ?? '',
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'orderId': _orderId,
      'address': _address,
      'shopId': _shopId,
      'dateScheduled': _dateScheduled,
      'isScheduled': _isScheduled,
      'name': _name,
      'paymentMethod': _paymentMethod,
      'status': _status,
      'foods': _foods.map((food) => food.toJson()).toList(),
      'timeScheduled': _timeScheduled,
      'userId': _userId,
    };
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

  bool get isScheduled {
    return _isScheduled;
  }

  String get timeScheduled {
    return _timeScheduled;
  }

  String get userId {
    return _userId;
  }

  set foods(List<Food> values) {
    _foods = values;
  }

}