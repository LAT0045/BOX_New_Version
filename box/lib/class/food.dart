import 'option.dart';

class Food {
  late String _foodId;
  late String _shopId;
  late String _foodName;
  late String _foodImage;
  late int _foodPrice;
  late String _foodDescription;
  late String _foodType;
  late List<Option> _options;
  late bool _isOutOfStock;
  late String _sectionId;
  late int _quantity;
  late String _foodNote;

  //_________CONSTRUCTOR_________
  Food(
      this._foodId,
      this._shopId,
      this._foodName,
      this._foodImage,
      this._foodPrice,
      this._foodDescription,
      this._foodType,
      this._options,
      this._isOutOfStock,
      this._sectionId,
      this._quantity,
      this._foodNote);

  Food.empty()
      : _foodId = '',
        _shopId = '',
        _foodName = '',
        _foodImage = '',
        _foodPrice = 0,
        _foodDescription = '',
        _foodType = '',
        _options = [],
        _isOutOfStock = false,
        _sectionId = '',
        _quantity = 0,
        _foodNote = '';

  //_________FACTORY_________

  factory Food.fromJson(String foodId, Map<String, dynamic> json) {
    int price = 0;
    if (json['foodPrice'].runtimeType == String) {
      // Check if it's a valid integer
      try {
        price = int.parse(json['foodPrice']);
      } catch (e) {
        // Error
      }
    } else {
      price = json['foodPrice'];
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
        json['sectionId'] ?? "",
        0,
        "");
  }

  //_________OPERATOR_________

  bool equals(Food other) {
    return _foodId == other._foodId &&
        _shopId == other._shopId &&
        _foodName == other._foodName &&
        _foodImage == other._foodImage &&
        _foodPrice == other._foodPrice &&
        _foodDescription == other._foodDescription &&
        _foodType == other._foodType &&
        deepEquals(_options, other._options) &&
        _isOutOfStock == other._isOutOfStock &&
        _sectionId == other._sectionId &&
        _foodNote == other._foodNote;
  }

  bool deepEquals(List<Option> list1, List<Option> list2) {
    if (list1.length != list2.length) {
      return false;
    }
    for (int i = 0; i < list1.length; i++) {
      if (!list1[i].equals(list2[i])) {
        return false;
      }
    }
    return true;
  }

  Food.copy(Food original)
      : _foodId = original._foodId,
        _shopId = original._shopId,
        _foodName = original._foodName,
        _foodImage = original._foodImage,
        _foodPrice = original._foodPrice,
        _foodDescription = original._foodDescription,
        _foodType = original._foodType,
        _options =
            original._options.map((option) => Option.copy(option)).toList(),
        _isOutOfStock = original._isOutOfStock,
        _sectionId = original._sectionId,
        _quantity = original._quantity,
        _foodNote = "";

  //_________FUNCTION_________

  void updateQuantity(int value, bool isDecreased) {
    if (isDecreased) {
      _quantity -= value;

      if (_quantity < 0) {
        _quantity = 0;
      }
    } else {
      _quantity += value;
    }
  }

  //_________GETTER AND SETTER_________

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

  String get sectionId {
    return _sectionId;
  }

  int get quantity {
    return _quantity;
  }

  String get foodNote {
    return _foodNote;
  }

  set options(List<Option> values) {
    _options = values;
  }

  set foodNote(String note) {
    _foodNote = note;
  }
}
