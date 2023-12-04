class OptionDetail {
  late String _name;
  late String _image;
  late bool _isOutOfStock;
  late int _price;
  late bool _isChosen;

  //_________CONSTRUCTOR_________

  OptionDetail(
      this._name, this._image, this._isOutOfStock, this._price, this._isChosen);

  OptionDetail.empty()
      : _name = '',
        _image = '',
        _isOutOfStock = false,
        _price = 0,
        _isChosen = false;

  OptionDetail.copy(OptionDetail original)
      : _name = original._name,
        _image = original._image,
        _isOutOfStock = original._isOutOfStock,
        _price = original._price,
        _isChosen = original._isChosen;

  //_________FACTORY_________

  factory OptionDetail.fromJson(Map<String, dynamic> json) {
    int price = 0;

    if (json['price'].runtimeType == String) {
      // Check if it's a valid integer
      try {
        price = int.parse(json['price']);
      } catch (e) {
        // Error
      }
    } else {
      price = json['price'];
    }

    return OptionDetail(json['name'] ?? "", json['image'] ?? "",
        json['isOutOfStock'] ?? true, price, false);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'image': _image,
      'isOutOfStock': _isOutOfStock,
      'price': _price,
    };
  }

  //_________OPERATOR_________
  bool equals(OptionDetail other) {
    return _name == other._name &&
        _image == other._image &&
        _isOutOfStock == other._isOutOfStock &&
        _price == other._price;
  }

  //_________GETTER AND SETTER_________

  String get name {
    return _name;
  }

  String get image {
    return _image;
  }

  bool get isOutOfStock {
    return _isOutOfStock;
  }

  int get price {
    return _price;
  }

  bool get isChosen {
    return _isChosen;
  }

  set isChosen(bool value) {
    _isChosen = value;
  }
}