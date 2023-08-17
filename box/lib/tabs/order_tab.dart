import 'package:box/cards/order_tracking_card.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderTab extends StatefulWidget {
  final bool isEmpty;

  const OrderTab({super.key, required this.isEmpty});

  @override
  State<StatefulWidget> createState() {
    return _OrderTabState();
  }
}

class _OrderTabState extends State<OrderTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: widget.isEmpty ? const EmptyOrder() : const Order());
  }
}

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "Đơn Hàng",
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ),
        ),
        Lottie.asset("assets/anim/shake_empty_box.json"),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Text(
            "Opps!!!",
            style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        const Text(
          "Hong có ai đang đến với bạn cạ :<<<",
          style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 20,
              color: AppColors.grayColor),
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppColors.mediumOrangeColor),
            child: const Text(
              "Đặt Thêm Món Nào",
              style: TextStyle(
                  fontFamily: 'Comfortaa', fontSize: 18, color: Colors.white),
            ))
      ],
    );
  }
}

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "Đơn Hàng",
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const OrderTrackingCard();
              }),
        )
      ],
    );
  }
}
