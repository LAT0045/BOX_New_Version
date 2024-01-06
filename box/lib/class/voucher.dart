class Voucher {
  late String vourcherId;
  late String shopId;
  late String voucherName;
  late String voucherCode;
  late String startDate;
  late String endDate;
  late String voucherType;
  late int value;
  late bool isShipping;
  late int orderCondition;

  Voucher(
    this.vourcherId,
    this.shopId,
    this.voucherName,
    this.voucherCode,
    this.startDate,
    this.endDate,
    this.voucherType,
    this.value,
    this.isShipping,
    this.orderCondition,
  );

  factory Voucher.fromJson(String voucherId, Map<String, dynamic> json) {
    return Voucher(
      voucherId,
      json['shopId'] ?? "",
      json['voucherName'] ?? "",
      json['voucherCode'] ?? "",
      json['startDate'] ?? "",
      json['endDate'] ?? "",
      json['voucherType'] ?? "",
      json['value'] ?? 0,
      json['isShipping'] ?? false,
      json['orderCondition'] ?? "",

    );
  }

  String toString() {
    return 'Voucher: {'
        'shopId: $shopId, '
        'voucherCode: $voucherName, '
        'voucherCode: $voucherCode, '
        'startDate: $startDate, '
        'endDate: $endDate,'
        'voucherType: $voucherType,'
        'value: $value,'
        'value: $orderCondition,'
        'isShipping: $isShipping,}\n';
  }

  bool isSelected = false;

  void toggleSelection() {
    isSelected = !isSelected;
  }
}