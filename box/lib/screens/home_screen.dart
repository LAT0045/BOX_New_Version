import 'package:box/tabs/favorite_tab.dart';
import 'package:box/tabs/notification_tab.dart';
import 'package:box/tabs/order_tab.dart';
import 'package:box/tabs/home_tab.dart';
import 'package:box/tabs/personal_info.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      const NotificationTab(isEmpty: true),
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