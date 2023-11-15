import 'dart:ffi';

import 'package:box/class/section.dart';

class Shop {
  late String _shopName;
  late String _shopImage;
  late String _shopAddress;
  late String _openingTime;
  late String _closingTime;
  late Float _ratingScore;
  late bool _isOpening;
  late List<Section> _sections;

  String get shopName {
    return _shopName;
  }

  String get shopImage {
    return _shopImage;
  }

  String get shopAddress {
    return _shopAddress;
  }

  String get openingTime {
    return _openingTime;
  }

  String get closingTime {
    return _closingTime;
  }

  Float get ratingScore {
    return _ratingScore;
  }

  bool get isOpening {
    return _isOpening;
  }

  List<Section> get sections {
    return _sections;
  }
}
