import 'package:box/class/shop.dart';
import 'package:box/screens/shop_screen.dart';
import 'package:box/service/location_service.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NearbyCard extends StatefulWidget {
  final String userAddress;
  final Shop shop;
  final bool hasVoucher;
  final String username;
  final String phoneNumber;
  final String address;
  final UserCredential userCredential;


  const NearbyCard({
    Key? key,
    required this.userAddress,
    required this.shop,
    required this.hasVoucher,
    required this.username,
    required this.phoneNumber,
    required this.address,
    required this.userCredential,


  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NearbyCardState();
  }
}

class _NearbyCardState extends State<NearbyCard> {
  double distance = 0.0;

  @override
  void initState() {
    super.initState();
    _updateDistance();
  }

  Future<void> _updateDistance() async {
    LocationService locationService = LocationService();
    double calculatedDistance =
        await locationService.calculateDistanceBetweenAddresses(
      widget.userAddress,
      widget.shop.shopAddress,
    );
    setState(() {
      distance = calculatedDistance;
    });
  }

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
              color: const Color(0xFFF7F7F7)),
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
                                AppColors.orangeColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "${distance.toStringAsFixed(2)} km",
                                style: const TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: widget.hasVoucher,
                        child: SizedBox(
                          width: 250,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/voucher.svg",
                                height: 25,
                                width: 25,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Mã giảm 20%",
                                  style: TextStyle(
                                      fontFamily: 'Comfortaa', fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ))
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
