import 'dart:convert';

class MyNotification {
  late String _title;
  late String _body;
  late String _time;

  MyNotification(this._title, this._body, this._time);

  Map<String, dynamic> toMap() {
    return {
      'title': _title,
      'body': _body,
      'time': _time,
    };
  }

  MyNotification.fromMap(Map<String, dynamic> map) {
    _title = map['title'];
    _body = map['body'];
    _time = map['time'];
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  MyNotification.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    _title = map['title'];
    _body = map['body'];
    _time = map['time'];
  }

  String get title {
    return _title;
  }

  String get body {
    return _body;
  }

  String get time {
    return _time;
  }
}
