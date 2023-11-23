import 'package:box/cards/shop_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../class/shop.dart';
import '../utils/colors.dart';

class CategoryDetail extends StatelessWidget {
  final String name;
  final List<Shop> shops;

  const CategoryDetail({super.key, required this.name, required this.shops});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Back button and screen name
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                height: 30,
                width: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          "assets/svg/backarrow.svg",
                          height: 30,
                          width: 30,
                          colorFilter: const ColorFilter.mode(
                              AppColors.orangeColor, BlendMode.srcIn),
                        ),
                      ),
                    ),

                    //
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        name,
                        style: const TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 20,
                            color: AppColors.orangeColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //
            Expanded(
                child: ListView.builder(
                    itemCount: shops.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ShopCard(
                        shop: shops[index],
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
