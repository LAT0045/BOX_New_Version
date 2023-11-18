import 'food.dart';

class Section {
  late String _sectionName;
  late List<String> _foodIds;
  late List<Food> _foods;

  Section(this._sectionName, this._foodIds);

  factory Section.fromJson(Map<String, dynamic> json) {
    List<String> foodIds = [];
    List<Object?> tmp = json['foods'];

    for (var element in tmp) {
      foodIds.add(element.toString());
    }

    return Section(json['sectionName'] ?? "", foodIds);
  }

  String get sectionName {
    return _sectionName;
  }

  List<String> get foodIds {
    return _foodIds;
  }

  List<Food> get food {
    return _foods;
  }
}
