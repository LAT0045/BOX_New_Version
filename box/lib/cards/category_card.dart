import 'package:box/details/category_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../class/shop.dart';

class CategoryCard extends StatelessWidget {
  final String iconPath;
  final String name;
  final List<Shop> shops;
  final String username;
  final String phoneNumber;
  final String address;
  final UserCredential userCredential;

  const CategoryCard(
      {super.key,
      required this.iconPath,
      required this.name,
      required this.shops,
      required this.username,
      required this.phoneNumber,
      required this.address,
      required this.userCredential});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryDetail(
              name: name,
              shops: shops,
              username: username,
              phoneNumber: phoneNumber,
              address: address,
              userCredential: userCredential,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 40,
              width: 40,
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              width: 70,
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(fontFamily: 'Comfortaa'),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}