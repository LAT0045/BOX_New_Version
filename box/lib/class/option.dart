import 'package:box/class/option_detail.dart';

class Option {
  late String _optionType;
  late String _optionName;
  late List<OptionDetail> _optionList;

  //_________CONSTRUCTOR_________

  Option(this._optionType, this._optionName, this._optionList);

  Option.copy(Option original)
      : _optionType = original._optionType,
        _optionName = original._optionName,
        _optionList = original._optionList
            .map((detail) => OptionDetail.copy(detail))
            .toList();

  //_________FACTORY_________

  factory Option.fromJson(Map<String, dynamic> json) {
    final List<OptionDetail> optionList = json['optionList'] != null
        ? List<OptionDetail>.from(json['optionList'].map((option) =>
            OptionDetail.fromJson(Map<String, dynamic>.from(option as Map))))
        : [];

    return Option(
        json['optionType'] ?? "", json['optionName'] ?? "", optionList);
  }

  //_________OPERATOR_________

  bool equals(Option other) {
    return _optionType == other._optionType &&
        _optionName == other._optionName &&
        deepEquals(_optionList, other._optionList);
  }

  bool deepEquals(List<OptionDetail> list1, List<OptionDetail> list2) {
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

  //_________FUNCTION_________

  void addToOptionList(OptionDetail optionDetail) {
    _optionList.add(optionDetail);
  }

  //_________GETTER AND SETTER_________

  String get optionType {
    return _optionType;
  }

  String get optionName {
    return _optionName;
  }

  List<OptionDetail> get optionList {
    return _optionList;
  }

  set optionList(List<OptionDetail> values) {
    _optionList = values;
  }
}
