import 'package:box/class/food.dart';
import 'package:box/screens/shop_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../class/shop.dart';
import '../utils/colors.dart';

class ShopCard extends StatefulWidget {
  final Shop shop;
  final String username;
  final String phoneNumber;
  final String address;
  final UserCredential userCredential;
  final List<String> favoriteFoods;
  final Function(Food, bool) updateFavoriteFoods;

  const ShopCard(
      {super.key,
      required this.shop,
      required this.username,
      required this.phoneNumber,
      required this.address,
      required this.userCredential,
      required this.favoriteFoods,
      required this.updateFavoriteFoods});
  @override
  State<StatefulWidget> createState() {
    return _ShopCardState();
  }
}

class _ShopCardState extends State<ShopCard> {
  //double distance = 0.0;

  @override
  void initState() {
    super.initState();
    //_updateDistance();
  }

  // Future<void> _updateDistance() async {
  //   LocationService locationService = LocationService();
  //   double calculatedDistance =
  //       await locationService.calculateDistanceBetweenAddresses(
  //     widget.address,
  //     widget.shop.shopAddress,
  //   );
  //   setState(() {
  //     distance = calculatedDistance;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ShopScreen(
              shop: widget.shop,
              username: widget.username,
              phoneNumber: widget.phoneNumber,
              address: widget.address,
              userCredential: widget.userCredential,
              favoriteFoods: widget.favoriteFoods,
              updateFavoriteFoods: widget.updateFavoriteFoods,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Color(0xFFECECEC), width: 2)),
              color: Colors.grey[200]),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.shop.shopImage),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        widget.shop.shopName,
                        style: const TextStyle(
                            fontFamily: 'Comfortaa', fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                      child: SizedBox(
                        width: 250,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/location_icon.svg",
                              height: 20,
                              width: 20,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.orangeColor, BlendMode.srcIn),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "${widget.shop.distance.toStringAsFixed(2)} km",
                                style: const TextStyle(
                                    fontFamily: 'Comfortaa', fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    //
                    SizedBox(
                      width: 250,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/star.svg",
                            height: 20,
                            width: 20,
                            colorFilter: const ColorFilter.mode(
                                AppColors.orangeColor, BlendMode.srcIn),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              widget.shop.ratingScore.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Comfortaa', fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
