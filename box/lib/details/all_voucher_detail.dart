import 'package:box/cards/voucher_detail_card.dart';
import 'package:box/class/voucher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../cards/order_food_card.dart';
import '../class/food.dart';
import '../utils/colors.dart';

class AllVoucherDetail extends StatefulWidget {
  final String shopId;
  final int subTotal;
  final int ship;
  const AllVoucherDetail(
      {super.key,
      required this.shopId,
      required this.subTotal,
      required this.ship});
  @override
  State<StatefulWidget> createState() {
    return _AllVoucherDetailState();
  }
}

class _AllVoucherDetailState extends State<AllVoucherDetail> {
  bool _isDoneGettingInfo = false;
  List<Voucher> shopVouchers = [];
  List<Voucher> adminVouchers = [];
  List<Voucher> shippingVouchers = [];

  Voucher? selectedShopVoucher;
  Voucher? selectedAdminVoucher;
  Voucher? selectedShippingVoucher;

  int appliedVoucherCount = 0;

  Future<Map<String, List<Voucher>>> getVouchers() async {
    final databaseReference = FirebaseDatabase.instance;
    final snapShot = await databaseReference.ref("Vouchers").get();
    final voucherMap = snapShot.value as Map;

    if (snapShot.value != null) {
      voucherMap.forEach((key, value) {
        Map<String, dynamic> voucherData =
            Map<String, dynamic>.from(value as Map);
        Voucher voucher = Voucher.fromJson(key.toString(), voucherData);
        if (voucher.isShipping && voucher.shopId == widget.shopId) {
          shippingVouchers.add(voucher);
        } else if (voucher.shopId == widget.shopId) {
          DateTime endDate = DateFormat('dd/MM/yyyy').parse(voucher.endDate);
          if (endDate.isAfter(DateTime.now())) {
            shopVouchers.add(voucher);
          }
        } else if (voucher.shopId == "admin") {
          DateTime endDate = DateFormat('dd/MM/yyyy').parse(voucher.endDate);
          if (endDate.isAfter(DateTime.now())) {
            adminVouchers.add(voucher);
          }
        }
      });
    }

    _isDoneGettingInfo = true;
    return {
      'shopVouchers': shopVouchers,
      'adminVouchers': adminVouchers,
      'shippingVouchers': shippingVouchers,
    };
  }

  @override
  void initState() {
    super.initState();
    loadVouchers();
  }

  void loadVouchers() async {
    Map<String, List<Voucher>> fetchedVouchers = await getVouchers();

    setState(() {
      shopVouchers = fetchedVouchers['shopVouchers'] ?? [];
      adminVouchers = fetchedVouchers['adminVouchers'] ?? [];
      shippingVouchers = fetchedVouchers['shippingVouchers'] ?? [];
    });
  }

  void selectVoucher(Voucher voucher) {
    setState(() {
      if (voucher.isShipping) {
        if (voucher.orderCondition > widget.subTotal) {
          voucher.isSelected = false;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Đơn hàng không đủ điều kiện',
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mediumOrangeColor,
                  ),
                ),
                content: Text(
                  'Đơn hàng của bạn không đủ điều kiện để sử dụng voucher này.',
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontSize: 13,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          if (selectedShippingVoucher == voucher) {
            selectedShippingVoucher = null;
          } else {
            selectedShippingVoucher = voucher;
            for (var v in shippingVouchers) {
              v.isSelected = v == voucher;
            }
          }
        }
      } else if (voucher.shopId == widget.shopId) {
        if (voucher.orderCondition > widget.subTotal) {
          voucher.isSelected = false;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Đơn hàng không đủ điều kiện',
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mediumOrangeColor,
                  ),
                ),
                content: Text(
                  'Đơn hàng của bạn không đủ điều kiện để sử dụng voucher này.',
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontSize: 13,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          if (selectedShopVoucher == voucher) {
            selectedShopVoucher = null;
          } else {
            selectedShopVoucher = voucher;
            for (var v in shopVouchers) {
              v.isSelected = v == voucher;
            }
          }
        }
      } else if (voucher.shopId == "admin") {
        if (voucher.orderCondition > widget.subTotal) {
          voucher.isSelected = false;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Đơn hàng không đủ điều kiện',
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mediumOrangeColor,
                  ),
                ),
                content: Text(
                  'Đơn hàng của bạn không đủ điều kiện để sử dụng voucher này.',
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontSize: 13,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          if (selectedAdminVoucher == voucher) {
            selectedAdminVoucher = null;
          } else {
            selectedAdminVoucher = voucher;
            for (var v in adminVouchers) {
              v.isSelected = v == voucher;
            }
          }
        }
      }
    });
  }

  int calculateDiscount(List<Voucher> vouchers, int subTotal, int ship) {
    int totalDiscount = 0;
    for (var voucher in vouchers) {
      if (voucher.isSelected) {
        appliedVoucherCount++;
        if (!voucher.isShipping) {
          if (voucher.voucherType == 'amount') {
            totalDiscount += voucher.value;
          } else if (voucher.voucherType == 'percent') {
            double discount = (voucher.value / 100) * subTotal;
            totalDiscount += discount.toInt();
          }
        } else {
          if (voucher.voucherType == 'amount') {
            totalDiscount += voucher.value;
          } else if (voucher.voucherType == 'percent') {
            double discount = (voucher.value / 100) * ship;
            totalDiscount += discount.toInt();
          }
        }
      }
    }

    return totalDiscount;
  }

  int calculateTotalDiscount() {
    int totalShopDiscount =
        calculateDiscount(shopVouchers, widget.subTotal, widget.ship);
    int totalAdminDiscount =
        calculateDiscount(adminVouchers, widget.subTotal, widget.ship);
    int totalShippingDiscount =
        calculateDiscount(shippingVouchers, widget.subTotal, widget.ship);

    return totalShopDiscount + totalAdminDiscount + totalShippingDiscount;
  }

  @override
  Widget build(BuildContext context) {
    int totalDiscount = calculateTotalDiscount();
    print(widget.subTotal);
    print(widget.ship);
    print('Tổng chiết khấu đã được tính: $totalDiscount');
    return Scaffold(
      appBar: AppBar(
        primary: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                  Navigator.of(context).pop(totalDiscount);
                },
                color: AppColors.mediumOrangeColor,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Các Voucher",
            style: TextStyle(
              fontFamily: "Comfortaa",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.mediumOrangeColor,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVoucherList("Mã giảm của shop", shopVouchers),
              _buildVoucherList("Mã giảm của BOX", adminVouchers),
              _buildVoucherList("Mã giảm phí giao hàng", shippingVouchers),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoucherList(String title, List<Voucher> voucherList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDivider(
            title, voucherList.isNotEmpty), // Add divider based on visibility
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: voucherList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: VoucherDetailCard(
                voucher: voucherList[index],
                onSelected: selectVoucher,
              ),
            );
          },
        ),
      ],
    );
  }
}

Widget _buildDivider(String title, bool isVisible) {
  return Visibility(
    visible: isVisible,
    child: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 40, left: 40),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              height: 0.5,
              color: AppColors.grayColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: "Comfortaa",
                fontSize: 14,
                color: AppColors.grayColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              height: 0.5,
              color: AppColors.grayColor,
            ),
          ),
        ],
      ),
    ),
  );
}
