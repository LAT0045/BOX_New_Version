import 'package:box/cards/order_tracking_card.dart';
import 'package:box/class/order.dart';
import 'package:box/class/shop.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderTab extends StatefulWidget {
  final UserCredential userCredential;

  OrderTab({super.key, required this.userCredential});

  @override
  State<StatefulWidget> createState() {
    return _OrderTabState();
  }
}

class _OrderTabState extends State<OrderTab> {
  bool isEmpty = false;
  bool _isDoneGettingInfo = false;
  final List<Order> _orders = [];
  final List<Shop> _shops = [];

  Future<void> getInfo() async {
    final databaseReference = FirebaseDatabase.instance;

    final orderSnapshot = await databaseReference.ref("Orders").get();
    final shopSnapshot = await databaseReference.ref("Shops").get();

    final orderMap = orderSnapshot.value as Map;

    final shopMap = shopSnapshot.value as Map;

    shopMap.forEach((key, value) {
      _shops.add(Shop.fromJson(
          key.toString(), Map<String, dynamic>.from(value as Map)));
    });

    orderMap.forEach((key, value) {
      _orders.add(Order.fromJson(
          key.toString(), Map<String, dynamic>.from(value as Map)));
    });
    _isDoneGettingInfo = true;

    _orders.isEmpty ? this.isEmpty = true : this.isEmpty = false;
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: isEmpty
            ? const EmptyOrder()
            : NotEmptyOrder(
                orders: _orders,
                shops: _shops,
              ));
  }
}

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            AppLocalizations.of(context)!.order,
            style: const TextStyle(
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
        Text(
          AppLocalizations.of(context)!.noComing,
          style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 20,
              color: AppColors.grayColor),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.mediumOrangeColor),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.orderMore,
                    style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              )),
        )
      ],
    );
  }
}

class NotEmptyOrder extends StatefulWidget {
  final List<Order> orders;
  final List<Shop> shops;
  NotEmptyOrder({super.key, required this.orders, required this.shops});

  @override
  State<StatefulWidget> createState() {
    return _NotEmptyOrderState();
  }
}

class _NotEmptyOrderState extends State<NotEmptyOrder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            AppLocalizations.of(context)!.order,
            style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.orders.length,
            itemBuilder: (context, index) {
              final order = widget.orders[index];
              final shop = widget.shops.firstWhere((shop) =>
                  shop.shopId ==
                  order.shopId); // Tìm cửa hàng tương ứng với đơn hàng
              return OrderTrackingCard(
                order: order,
                shop: shop, // Chuyển thông tin cửa hàng vào OrderTrackingCard
              );
            },
          ),
        )
      ],
    );
  }
}
