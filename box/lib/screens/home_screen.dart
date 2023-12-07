import 'package:awesome_notifications/awesome_notifications.dart';
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

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

  @override
  void initState() {
    super.initState();
    startOrderStatusListener();
  }

  @override
  Widget build(BuildContext context) {
    final List tabs = [
      HomeTab(
        address: widget.address,
        userCredential: widget.userCredential,
      ),
      const FavoriteTab(isEmpty: true),
      OrderTab(
        userCredential: widget.userCredential,
      ),
      NotificationTab(userCredential: widget.userCredential),
      PersonalInfoTab(
        userCredential: widget.userCredential,
      )
    ];

    return Scaffold(
      body: tabs[_selectedIndex],
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
