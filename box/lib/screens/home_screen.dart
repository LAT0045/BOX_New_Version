import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:box/class/food.dart';
import 'package:box/class/section.dart';
import 'package:box/class/shop.dart';
import 'package:box/service/location_service.dart';
import 'package:box/tabs/favorite_tab.dart';
import 'package:box/tabs/notification_tab.dart';
import 'package:box/tabs/order_tab.dart';
import 'package:box/tabs/home_tab.dart';
import 'package:box/tabs/personal_info_tab.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:box/class/my_notification.dart';

class HomeScreen extends StatefulWidget {
  final UserCredential userCredential;
  final String address;

  const HomeScreen(
      {super.key, required this.userCredential, required this.address});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isDoneGettingInfo = false;

  List<Shop> _shops = [];
  List<String> _favoriteFoodIds = [];
  List<Food> _favoriteFoods = [];
  List<Food> _foods = [];

  String _phoneNumber = "";
  String _name = "";

  //__________________________________________________

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void updateFavoriteFood(Food food, bool isRemoved) {
    String userId = widget.userCredential.user!.uid.toString();
    final databaseReference = FirebaseDatabase.instance
        .ref("Users")
        .child(userId)
        .child("favoriteFoods");

    if (isRemoved) {
      setState(() {
        _favoriteFoodIds.removeWhere((element) => element == food.foodId);
        _favoriteFoods.removeWhere((element) => element.foodId == food.foodId);
      });
      databaseReference.child(food.foodId).remove();
    } else {
      setState(() {
        _favoriteFoodIds.add(food.foodId);
        _favoriteFoods.add(food);
      });

      databaseReference.push().set(food.foodId);
    }
  }

  //__________________________________________________

  //________________GET INFOMATION____________________

  Future<void> getInfo() async {
    final databaseReference = FirebaseDatabase.instance;

    // Get user reference
    final databaseReference2 = databaseReference.ref("Users");
    DatabaseReference userReference =
        databaseReference2.child(widget.userCredential.user!.uid);

    // Get Shop and Food snapshot
    final shopSnapshot = await databaseReference.ref("Shops").get();
    final foodSnapshot = await databaseReference.ref("Foods").get();

    // Get user favorite food snapshot
    final favoriteSnapshot = await userReference.child("favoriteFoods").get();

    // Mapping Shop and Food infomation
    final shopMap = shopSnapshot.value as Map;
    final foodMap = foodSnapshot.value as Map;

    // Get Shop and Food list
    shopMap.forEach((key, value) {
      _shops.add(Shop.fromJson(
          key.toString(), Map<String, dynamic>.from(value as Map)));
    });

    foodMap.forEach((key, value) {
      Food food = Food.fromJson(
          key.toString(), Map<String, dynamic>.from(value as Map));

      _foods.add(food);
    });

    if (favoriteSnapshot.exists) {
      setState(() {
        final favoriteMap = favoriteSnapshot.value as Map;
        favoriteMap.forEach((key, value) {
          _favoriteFoodIds.add(value);
        });
      });
    }

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

    // Sort favorite foods
    setState(() {
      _favoriteFoods = _foods
          .where((food) => _favoriteFoodIds.contains(food.foodId))
          .toList();
    });

    _isDoneGettingInfo = true;
  }

  //________________END INFOMATION____________________

  //________________NOTIFICATION_______________________
  Future<void> startOrderStatusListener() async {
    final DatabaseReference orderReference =
        FirebaseDatabase.instance.ref().child("Orders");
    final String? userId = widget.userCredential.user?.uid.toString();

    if (userId != null) {
      orderReference
          .orderByChild('userId')
          .equalTo(userId)
          .onChildChanged
          .listen((event) {
        //
        DataSnapshot dataSnapshot = event.snapshot;
        String orderId = dataSnapshot.key.toString();
        String newStatus = (dataSnapshot.value as Map)["status"];

        print(orderId);
        print(newStatus);

        if (newStatus == 'ACCEPTED') {
          showNotification(newStatus, orderId, userId);
        } else if (newStatus == 'DENIED') {
          showNotification(newStatus, orderId, userId);
        } else if (newStatus == 'COMPLETED') {
          showNotification(newStatus, orderId, userId);
        }
      });
    }
  }

  String getNotificationText(String status) {
    switch (status) {
      case "ACCEPTED":
        return "Đơn hàng của bạn vừa được chấp nhận!";
      case "DENIED":
        return "Đơn hàng của bạn bị từ chối!";
      case "COMPLETED":
        return "Đơn hàng của bạn đã hoàn thành!";
      default:
        return "";
    }
  }

  Future<void> showNotification(
      String status, String orderId, String userId) async {
    String title = "Thông báo đơn hàng";
    String body = getNotificationText(status);

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 0,
      channelKey: 'main_channel',
      title: title,
      body: body,
      displayOnBackground: true,
      displayOnForeground: true,
    ));

    MyNotification newNotification =
        MyNotification(title, body, DateTime.now().toString(), orderId);

    final snapShot = await FirebaseDatabase.instance
        .ref("Notifications")
        .child(userId)
        .child(orderId)
        .get();

    if (snapShot.exists) {
      String oldBody = (snapShot.value as Map)["body"];

      if (oldBody != body) {
        pushNewNotification(newNotification, userId);
      }
    } else {
      pushNewNotification(newNotification, userId);
    }
  }

  Future<void> pushNewNotification(
      MyNotification notification, String id) async {
    try {
      // Get a reference to the Realtime Database instance
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("Notifications").child(id);

      // Add data
      databaseReference.push().set({
        'title': notification.title,
        'body': notification.body,
        'time': notification.time,
        'orderId': notification.orderId
      });
    } catch (e) {
      // Error
    }
  }
  //_____________END NOTIFICATION_______________________

  @override
  void initState() {
    super.initState();
    getInfo();
    startOrderStatusListener();
  }

  @override
  Widget build(BuildContext context) {
    final List tabs = [
      HomeTab(
        address: widget.address,
        userCredential: widget.userCredential,
        favoriteFoods: _favoriteFoodIds,
        foods: _foods,
        shops: _shops,
        updateFavoriteFoods: updateFavoriteFood,
      ),
      FavoriteTab(
        isEmpty: _favoriteFoods.isEmpty,
        favoriteFoods: _favoriteFoods,
        updateFavoriteFoods: updateFavoriteFood,
      ),
      OrderTab(
        address: widget.address,
        userCredential: widget.userCredential,
      ),
      NotificationTab(userCredential: widget.userCredential),
      PersonalInfoTab(
        userCredential: widget.userCredential,
      )
    ];

    return Scaffold(
      body: _isDoneGettingInfo
          ? tabs[_selectedIndex]
          : SafeArea(
              child: Center(
              child: CircularProgressIndicator(),
            )),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.orangeColor,
          unselectedItemColor: AppColors.grayColor,
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/home_icon.svg",
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == 0
                          ? AppColors.orangeColor
                          : AppColors.grayColor,
                      BlendMode.srcIn),
                ),
                label: AppLocalizations.of(context)!.homePage),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/favorite_icon.svg",
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == 1
                          ? AppColors.orangeColor
                          : AppColors.grayColor,
                      BlendMode.srcIn),
                ),
                label: AppLocalizations.of(context)!.favorite),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/order_icon.svg",
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == 2
                          ? AppColors.orangeColor
                          : AppColors.grayColor,
                      BlendMode.srcIn),
                ),
                label: "Đơn Hàng"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/notification_icon.svg",
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == 3
                          ? AppColors.orangeColor
                          : AppColors.grayColor,
                      BlendMode.srcIn),
                ),
                label: AppLocalizations.of(context)!.notification),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/user_icon.svg",
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == 4
                          ? AppColors.orangeColor
                          : AppColors.grayColor,
                      BlendMode.srcIn),
                ),
                label: "Tài Khoản")
          ]),
    );
  }
}
