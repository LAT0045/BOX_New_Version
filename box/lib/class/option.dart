import 'package:box/class/option_detail.dart';

class Option {
  late String _optionType;
  late String _optionName;
  late List<OptionDetail> _optionList;

  Option(this._optionType, this._optionName, this._optionList);

  factory Option.fromJson(Map<String, dynamic> json) {
    final List<OptionDetail> optionList = json['optionList'] != null
        ? List<OptionDetail>.from(json['optionList'].map((option) =>
            OptionDetail.fromJson(Map<String, dynamic>.from(option as Map))))
        : [];

    return Option(
        json['optionType'] ?? "", json['optionName'] ?? "", optionList);
  }

  String get optionType {
    return _optionType;
  }

  String get optionName {
    return _optionName;
  }

  List<OptionDetail> get optionList {
    return _optionList;
  }
}
