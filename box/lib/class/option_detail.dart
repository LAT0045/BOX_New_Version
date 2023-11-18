class OptionDetail {
  late String _name;
  late String _image;
  late bool _isOutOfStock;
  late int _price;

  OptionDetail(this._name, this._image, this._isOutOfStock, this._price);

  factory OptionDetail.fromJson(Map<String, dynamic> json) {
    int price = 0;

    if (json['price'].runtimeType == String) {
      // Check if it's a valid integer
      try {
        price = int.parse(json['price']);
      } catch (e) {
        // Error
      }
    }

    return OptionDetail(json['name'] ?? "", json['image'] ?? "",
        json['isOutOfStock'] ?? true, price);
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
}
