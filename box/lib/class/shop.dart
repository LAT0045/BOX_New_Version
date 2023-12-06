import 'package:box/class/section.dart';

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
  late double distance = 0;

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
    final List<Section> sections = json['sections'] != null
        ? List<Section>.from(json['sections'].asMap().entries.map((entry) =>
            Section.fromJson(entry.key.toString(),
                Map<String, dynamic>.from(entry.value as Map))))
        : [];

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
