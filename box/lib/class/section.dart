import 'food.dart';

class Section {
  late String _sectionId;
  late String _sectionName;
  late List<Food> _foods;

  Section(this._sectionId, this._sectionName, this._foods);

  void addFood(Food food) {
    _foods.add(food);
  }

  factory Section.fromJson(String sectionId, Map<String, dynamic> json) {
    return Section(sectionId, json['sectionName'] ?? "", []);
  }

  String get sectionId {
    return _sectionId;
  }

  String get sectionName {
    return _sectionName;
  }

  List<Food> get foods {
    return _foods;
  }
}
