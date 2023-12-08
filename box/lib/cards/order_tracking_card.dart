import 'package:box/class/food.dart';
import 'package:box/class/order.dart';
import 'package:box/class/shop.dart';
import 'package:box/details/check_out_detail.dart';
import 'package:box/details/delivery_detail.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderTrackingCard extends StatefulWidget {
  final Order order;
  final Shop shop;
  final String foodImage;
  final List<Food> foods;
  final String username;
  final String phoneNumber;
  final String address;
  final UserCredential userCredential;

  const OrderTrackingCard({
    super.key, 
    required this.order, 
    required this.shop, 
    required this.foodImage,
    required this.foods,
    required this.username,
    required this.phoneNumber,
    required this.address,
    required this.userCredential});
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
      height: 150,
      width: double.infinity,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFFECECEC), width: 2)),
          color: const Color(0xFFF7F7F7)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                widget.foodImage,
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top:8, left: 8, right: 8),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        widget.shop.shopName,
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF000000)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
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
                            color: AppColors.greenColor),
                      ),
                    ),
                    SizedBox(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DeliveryDetail(
                                  order: widget.order,
                                  shop: widget.shop,
                                  foodImage: widget.foodImage,
                                  foods: widget.order.foods,
                                  username: widget.username,
                                  phoneNumber: widget.phoneNumber,
                                  address: widget.address,
                                  userCredential: widget.userCredential,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Xem chi tiết",
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 15,
                                color: AppColors.blueColor),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
