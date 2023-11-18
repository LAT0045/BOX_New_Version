import 'option.dart';

class Food {
  late final String _foodId;
  late final String _shopId;
  late final String _foodName;
  late final String _foodImage;
  late final int _foodPrice;
  late final String _foodDescription;
  late final String _foodType;
  late final List<Option> _options;
  late final bool _isOutOfStock;

  Food(
      this._foodId,
      this._shopId,
      this._foodName,
      this._foodImage,
      this._foodPrice,
      this._foodDescription,
      this._foodType,
      this._options,
      this._isOutOfStock);

  factory Food.fromJson(String foodId, Map<String, dynamic> json) {
    int price = 0;
    if (json['foodPrice'].runtimeType == String) {
      // Check if it's a valid integer
      try {
        price = int.parse(json['foodPrice']);
      } catch (e) {
        // Error
      }
    }

    final List<Option> options = json['options'] != null
        ? List<Option>.from(json['options'].map((option) =>
            Option.fromJson(Map<String, dynamic>.from(option as Map))))
        : [];

    return Food(
      foodId,
      json['shopId'] ?? "",
      json['foodName'] ?? "",
      json['foodImage'] ?? "",
      price,
      json['foodDescription'] ?? "",
      json['foodType'] ?? "",
      options,
      json['isOutOfStock'] ?? "",
    );
  }

  String get foodId {
    return _foodId;
  }

  String get shopId {
    return _shopId;
  }

  String get foodName {
    return _foodName;
  }

  String get foodImage {
    return _foodImage;
  }

  int get foodPrice {
    return _foodPrice;
  }

  String get foodDescription {
    return _foodDescription;
  }

  String get foodType {
    return _foodType;
  }

  List<Option> get options {
    return _options;
  }

  bool get isOutOfStock {
    return _isOutOfStock;
  }
}
