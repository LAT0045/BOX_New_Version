import 'package:box/cards/order_tracking_card.dart';
import 'package:box/class/food.dart';
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
  final String address;

  OrderTab({super.key, required this.userCredential, required this.address});

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

  String _phoneNumber = "";
  String _name = "";

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
    _orders.clear();

    orderMap.forEach((key, value) {
      Order order = Order.fromJson(
        key.toString(), Map<String, dynamic>.from(value as Map)
      );

      List<Food> foods = [];
      if (value['foods'] is List) {
        (value['foods'] as List).forEach((foodData) {
          if (foodData is Map) {
            Food food = Food.fromJson(foodData['key'].toString(), Map<String, dynamic>.from(foodData));
            foods.add(food);
          }
        });
      }

      order.foods = foods;

      _orders.add(order);
    });

    final databaseReference2 = databaseReference.ref("Users");
      DatabaseReference userReference =
          databaseReference2.child(widget.userCredential.user!.uid);

      final snapshot = await userReference.get();
        if (snapshot.exists) {
          setState(() {
            _name = (snapshot.value as Map)["name"];
            _phoneNumber = (snapshot.value as Map)["phoneNumber"] ??
                AppLocalizations.of(context)!.notUpdate;
          });
        } else {
          // User info doesn't exist
        }

      _isDoneGettingInfo = true;
      
  }

  List<Order> filterOrdersByUserIdAndStatus(String userId,List<String> status) {
    return _orders.where((order) {
      return order.userId == userId && status.contains(order.status);
    }).toList();
  }

  List<Order> filteredOrders = [];

  void updateFilteredOrders() {
    setState(() {
      filteredOrders = filterOrdersByUserIdAndStatus(
          widget.userCredential.user!.uid,  ['PENDING', 'DELIVERING', 'ACCEPTED']);
    });
  }

  @override
  void initState() {
    super.initState();
    getInfo().then((_) {
      updateFilteredOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: filteredOrders.isEmpty
            ? const EmptyOrder()
            : NotEmptyOrder(
                orders: filteredOrders,
                shops: _shops,
                phoneNumber: _phoneNumber,
                name: _name,
                address: widget.address,
                userCredential: widget.userCredential,
                isDoneGettingInfo: _isDoneGettingInfo,
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
  final String phoneNumber;
  final String name;
  final String address;
  final UserCredential userCredential;
  final bool isDoneGettingInfo;
  NotEmptyOrder({
    super.key, 
    required this.orders, 
    required this.shops, 
    required this.phoneNumber, 
    required this.name, 
    required this.address,
    required this.userCredential,
    required this.isDoneGettingInfo,
    });

  @override
  State<StatefulWidget> createState() {
    return _NotEmptyOrderState();
  }
}

class _NotEmptyOrderState extends State<NotEmptyOrder> {
  @override
  Widget build(BuildContext context) {
    return !widget.isDoneGettingInfo
        ? SafeArea(
            child: Center(
            child: CircularProgressIndicator(),
          ))
        : Column(
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
                      order.shopId); 
                  String firstFoodImage = '';
                  if (order.foods.isNotEmpty && firstFoodImage.isEmpty) {
                    firstFoodImage = order.foods.first.foodImage ?? '';
                  }
                  return OrderTrackingCard(
                    order: order,
                    shop: shop,
                    foodImage: firstFoodImage,
                    userCredential: widget.userCredential,
                    address: widget.address,
                    username: widget.name,
                    phoneNumber: widget.phoneNumber,
                    foods: order.foods,
                    //foods: widget.orders,
                  );
                },
              ),
            )
          ],
        );
  }
}
