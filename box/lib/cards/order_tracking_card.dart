import 'package:box/class/order.dart';
import 'package:box/class/shop.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';

class OrderTrackingCard extends StatefulWidget {
  final Order order;
  final Shop shop;

  const OrderTrackingCard({super.key, required this.order, required this.shop});
  @override
  State<StatefulWidget> createState() {
    return _OrderTrackingCardState();
  }
}

class _OrderTrackingCardState extends State<OrderTrackingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 120,
      width: double.infinity,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFFECECEC), width: 2)),
          color: const Color(0xFFF7F7F7)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/test/ca_phe_kem_trung.jpeg',
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  widget.shop.shopName,
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 15,
                      color: Color(0xFF000000)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: 200,
                  child: Text(
                    widget.order.address,
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 15,
                        color: Color(0xFF000000)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Text(
                  widget.order.status,
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 15,
                      color: AppColors.blueColor),
                ),
              ),
              SizedBox(
                width: 200,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Text(
                      "Xem chi tiết",
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                          color: AppColors.mediumOrangeColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
