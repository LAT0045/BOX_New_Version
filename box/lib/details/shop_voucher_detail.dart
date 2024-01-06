import 'package:box/class/food.dart';
import 'package:box/class/message.dart';
import 'package:box/class/shop.dart';
import 'package:box/class/voucher.dart';
import 'package:box/screens/shop_screen.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ShopVoucherDetail extends StatefulWidget {
  final List<Voucher> vouchers;
  ShopVoucherDetail({super.key, required this.vouchers});

  @override
  _ShopVoucherDetailState createState() => _ShopVoucherDetailState();
}

class _ShopVoucherDetailState extends State<ShopVoucherDetail> {
  @override
  Widget build(BuildContext context) {
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
                  Navigator.of(context).pop();
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
      body: ListView.builder(
        itemCount: widget.vouchers.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/voucher_shop.svg',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nhập: "${widget.vouchers[index].voucherCode}" - ${widget.vouchers[index].voucherName}',
                        style: TextStyle(
                          fontFamily: "Comfortaa",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mediumOrangeColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 28, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Đơn tối thiểu " +
                            "${NumberFormat.decimalPattern().format(widget.vouchers[index].orderCondition).replaceAll(',', '.')}Đ",
                        style: TextStyle(
                          fontFamily: "Comfortaa",
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Ngày bắt đầu: " +
                            "${widget.vouchers[index].startDate}",
                        style: TextStyle(
                          fontFamily: "Comfortaa",
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Ngày kết thúc: " + "${widget.vouchers[index].endDate}",
                        style: TextStyle(
                          fontFamily: "Comfortaa",
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
