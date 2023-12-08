class MyNotification {
  late String _title;
  late String _body;
  late String _time;
  late String _orderId;

  MyNotification(this._title, this._body, this._time, this._orderId);

  //_________FACTORY_________

  factory MyNotification.fromJson(Map<String, dynamic> json) {
    return MyNotification(json['title'] ?? "", json['body'] ?? "",
        json['time'] ?? "", json['orderId'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'title': _title,
      'body': _body,
      'time': _time,
      'orderId': _orderId,
    };
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

  String get orderId {
    return _orderId;
  }
}
