import 'package:box/class/section.dart';

import 'food.dart';

class Shop {
  late String _shopId;
  late String _shopName;
  late String _shopImage;
  late String _shopAddress;
  late String _openingTime;
  late String _closingTime;
  late double _ratingScore;
  late bool _isOpening;
  late List<Section> _sections;

  Shop(
      this._shopId,
      this._shopName,
      this._shopImage,
      this._shopAddress,
      this._openingTime,
      this._closingTime,
      this._ratingScore,
      this._isOpening,
      this._sections);

  factory Shop.fromJson(String shopId, Map<String, dynamic> json) {
    List<Section> sections = [];

    if (json['sections'] != null) {
      final sectionMap = json['sections'] as Map;

      sectionMap.forEach((key, value) {
        sections.add(Section.fromJson(
            key.toString(), Map<String, dynamic>.from(value as Map)));
      });
    }

    var tmp = json['ratingScore'];
    double score = 0;

    if (tmp is double) {
      score = tmp;
    } else {
      score = double.parse(tmp.toString());
    }

    return Shop(
        shopId,
        json['shopName'] ?? "",
        json['shopImage'] ?? "",
        json['shopAddress'] ?? "",
        json['openingTime'] ?? "",
        json['closingTime'] ?? "",
        score,
        json['isOpening'] ?? "",
        sections);
  }

  String get shopId {
    return _shopId;
  }

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

  double get ratingScore {
    return _ratingScore;
  }

  bool get isOpening {
    return _isOpening;
  }

  List<Section> get sections {
    return _sections;
  }
}
