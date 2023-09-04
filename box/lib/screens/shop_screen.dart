import 'package:box/cards/section_card.dart';
import 'package:box/cards/horizontal_food_card.dart';
import 'package:box/cards/voucher_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/colors.dart';

class ShopScreen extends StatefulWidget {
  ShopScreen({super.key});

  final List<VoucherCard> _vouchers = [
    const VoucherCard(),
    const VoucherCard(),
    const VoucherCard()
  ];

  final List<HorizontalFoodCard> _foods = [
    const HorizontalFoodCard(),
    const HorizontalFoodCard(),
    const HorizontalFoodCard()
  ];

  @override
  State<StatefulWidget> createState() {
    return _ShopScreenState();
  }
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              // Shop Image and back button
              Stack(
                children: [
                  Image.asset(
                    'assets/test/milano_coffee.jpg',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/svg/backarrow.svg",
                        height: 35,
                        width: 35,
                        colorFilter: const ColorFilter.mode(
                            AppColors.orangeColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              // Shop name and rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        "Milano Coffee",
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(children: [
                      SvgPicture.asset(
                        "assets/svg/star.svg",
                        height: 20,
                        width: 20,
                        colorFilter: const ColorFilter.mode(
                            AppColors.orangeColor, BlendMode.srcIn),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 3, left: 5),
                        child: Text(
                          "4.5/5.0",
                          style:
                              TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
                        ),
                      )
                    ]),
                  )
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              // Location
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/location_icon.svg",
                      height: 20,
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                          AppColors.grayColor, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Địa chỉ nè",
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                          color: AppColors.grayColor),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Time
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/clock.svg",
                      height: 20,
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                          AppColors.grayColor, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 2.5),
                      child: Text(
                        "07:00 - 22:00",
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 15,
                            color: AppColors.grayColor),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: 10,
                  color: AppColors.lightGrayColor,
                ),
              ),

              // Voucher
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mã Giảm Giá",
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 20,
                          color: AppColors.orangeColor),
                    ),
                  ),
                ),
              ),

              for (int i = 0; i < widget._vouchers.length; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget._vouchers[i],
                ),

              const SizedBox(
                height: 10,
              ),

              // Food
              SectionCard(sectionName: "Cà Phê", widgets: widget._foods),

              const SizedBox(
                height: 10,
              ),

              // Food 2
              SectionCard(sectionName: "Trà Sữa", widgets: widget._foods),

              const SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
                color: AppColors.mediumOrangeColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  "assets/svg/cart.svg",
                  height: 25,
                  width: 25,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                Text(
                  "2 ${AppLocalizations.of(context)!.product}",
                  style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      color: Colors.white,
                      fontSize: 15),
                ),
                const Text(
                  "100.000Đ",
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      color: Colors.white,
                      fontSize: 20),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.pay,
                          style: const TextStyle(
                              fontFamily: 'Comfortaa',
                              color: AppColors.mediumOrangeColor,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.east_outlined,
                          color: AppColors.mediumOrangeColor,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ])),
    );
  }
}
