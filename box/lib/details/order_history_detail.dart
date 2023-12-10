import 'package:box/cards/order_tracking_card.dart';
import 'package:box/class/food.dart';
import 'package:box/class/order.dart';
import 'package:box/class/shop.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderHistoryDetail extends StatefulWidget {
  final UserCredential userCredential;
  final String address;

  OrderHistoryDetail(
      {super.key, required this.userCredential, required this.address});

  @override
  _OrderHistoryDetailState createState() => _OrderHistoryDetailState();
}

class _OrderHistoryDetailState extends State<OrderHistoryDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
          key.toString(), Map<String, dynamic>.from(value as Map));

      List<Food> foods = [];
      if (value['foods'] is List) {
        (value['foods'] as List).forEach((foodData) {
          if (foodData is Map) {
            Food food = Food.fromJson(foodData['key'].toString(),
                Map<String, dynamic>.from(foodData));
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

  List<Order> filterOrdersByUserIdAndStatus(
      String userId, List<String> status) {
    return _orders.where((order) {
      return order.userId == userId && status.contains(order.status);
    }).toList();
  }

  List<Order> completedOrders = [];
  List<Order> canceledOrders = [];

  void updateFilteredOrders() {
    setState(() {
      completedOrders = filterOrdersByUserIdAndStatus(
          widget.userCredential.user!.uid, ['COMPLETED']);
      canceledOrders = filterOrdersByUserIdAndStatus(
          widget.userCredential.user!.uid, ['DENIED']);
    });
  }

  @override
  void initState() {
    super.initState();
    getInfo().then((_) {
      updateFilteredOrders();
    });
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.orangeColor),
        title: const Text(
          'Lịch sử đơn hàng',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 20,
            color: AppColors.orangeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'Đã hoàn thành',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Đã hủy',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          indicatorWeight: 2.0,
          indicatorColor: AppColors.mediumOrangeColor,
          unselectedLabelColor: AppColors.grayColor,
          labelColor: AppColors.mediumOrangeColor,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CompletedOrdersTab(
            orders: completedOrders,
            shops: _shops,
            phoneNumber: _phoneNumber,
            name: _name,
            address: widget.address,
            userCredential: widget.userCredential,
          ),
          CanceledOrdersTab(
            orders: canceledOrders,
            shops: _shops,
            phoneNumber: _phoneNumber,
            name: _name,
            address: widget.address,
            userCredential: widget.userCredential,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class CompletedOrdersTab extends StatelessWidget {
  final List<Order> orders;
  final List<Shop> shops;
  final String phoneNumber;
  final String name;
  final String address;
  final UserCredential userCredential;

  CompletedOrdersTab({
    required this.orders,
    required this.shops,
    required this.phoneNumber,
    required this.name,
    required this.address,
    required this.userCredential,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 10),
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final shop = shops.firstWhere((shop) => shop.shopId == order.shopId);
          String firstFoodImage = '';
          if (order.foods.isNotEmpty && firstFoodImage.isEmpty) {
            firstFoodImage = order.foods.first.foodImage ?? '';
          }
          return OrderTrackingCard(
            order: order,
            shop: shop,
            foodImage: firstFoodImage,
            userCredential: userCredential,
            address: address,
            username: name,
            phoneNumber: phoneNumber,
            foods: order.foods,
            //foods: widget.orders,
          );
        },
      ),
    );
  }
}

class CanceledOrdersTab extends StatelessWidget {
  final List<Order> orders;
  final List<Shop> shops;
  final String phoneNumber;
  final String name;
  final String address;
  final UserCredential userCredential;

  CanceledOrdersTab({
    required this.orders,
    required this.shops,
    required this.phoneNumber,
    required this.name,
    required this.address,
    required this.userCredential,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 10),
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final shop = shops.firstWhere((shop) => shop.shopId == order.shopId);
          String firstFoodImage = '';
          if (order.foods.isNotEmpty && firstFoodImage.isEmpty) {
            firstFoodImage = order.foods.first.foodImage ?? '';
          }
          return OrderTrackingCard(
            order: order,
            shop: shop,
            foodImage: firstFoodImage,
            userCredential: userCredential,
            address: address,
            username: name,
            phoneNumber: phoneNumber,
            foods: order.foods,
            //foods: widget.orders,
          );
        },
      ),
    );
  }
}