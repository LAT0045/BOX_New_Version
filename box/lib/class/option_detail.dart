class OptionDetail {
  late String _name;
  late String _image;
  late bool _isOutOfStock;
  late int _price;
  late bool _isChosen;

  OptionDetail(
      this._name, this._image, this._isOutOfStock, this._price, this._isChosen);

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
