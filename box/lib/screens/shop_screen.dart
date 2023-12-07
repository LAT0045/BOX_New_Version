import 'package:box/cards/section_card.dart';
import 'package:box/cards/voucher_card.dart';
import 'package:box/screens/order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../class/food.dart';
import '../class/option.dart';
import '../class/option_detail.dart';
import '../class/shop.dart';
import '../utils/colors.dart';

class ShopScreen extends StatefulWidget {
  final Shop shop;
  final String username;
  final String phoneNumber;
  final String address;
  final UserCredential userCredential;

  ShopScreen(
      {super.key,
      required this.shop,
      required this.username,
      required this.phoneNumber,
      required this.address,
      required this.userCredential});

  final List<VoucherCard> _vouchers = [
    const VoucherCard(),
    const VoucherCard(),
    const VoucherCard()
  ];

  @override
  State<StatefulWidget> createState() {
    return _ShopScreenState();
  }
}

class _ShopScreenState extends State<ShopScreen> {
  int totalFoods = 0;
  int totalPrice = 0;
  List<Food> purchasedFoods = [];

  void updateTotalFoods(int quantity, bool isDecreased) {
    setState(() {
      if (isDecreased) {
        totalFoods -= quantity;
      } else {
        totalFoods += quantity;
      }
    });
  }

  void updateTotalPrice(Food food, bool isRemoved) {
    setState(() {
      if (isRemoved) {
        totalPrice -= calculateTotalPrice(food);
      } else {
        totalPrice += calculateTotalPrice(food);
      }
    });
  }

  int calculateTotalPrice(Food food) {
    int res = food.foodPrice;

    for (Option option in food.options) {
      res += calculateOptionDetail(option.optionList);
    }

    return res;
  }

  int calculateOptionDetail(List<OptionDetail> optionDetails) {
    int res = 0;

    for (OptionDetail optionDetail in optionDetails) {
      res += optionDetail.price;
    }

    return res;
  }

  int getFoodFromList(Food food, List<Food> foods) {
    int res = -1;

    for (int i = 0; i < foods.length; i++) {
      if (foods[i].equals(food)) {
        res = i;
      }
    }

    return res;
  }

  void updatePurchasedFood(Food food, bool isRemoved) {
    setState(() {
      int index = getFoodFromList(food, purchasedFoods);

      if (isRemoved) {
        if (index != -1) {
          purchasedFoods[index].updateQuantity(1, true);

          if (purchasedFoods[index].quantity == 0) {
            purchasedFoods.removeAt(index);
          }
        }
      } else {
        if (index != -1) {
          // Already has same food in list
          purchasedFoods[index].updateQuantity(1, false);
        } else {
          // No food exists in list
          // Add new one
          purchasedFoods.add(food);
        }
      }
    });
  }

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
                  Image.network(
                    widget.shop.shopImage,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        widget.shop.shopName,
                        style: const TextStyle(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 3, left: 5),
                        child: Text(
                          "${widget.shop.ratingScore}/5.0",
                          style: const TextStyle(
                              fontFamily: 'Comfortaa', fontSize: 15),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Expanded(
                      child: Text(
                        widget.shop.shopAddress,
                        style: const TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 15,
                            color: AppColors.grayColor),
                      ),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 2.5),
                      child: Text(
                        "${widget.shop.openingTime} - ${widget.shop.closingTime}",
                        style: const TextStyle(
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

              for (int i = 0; i < widget.shop.sections.length; i++)
                SectionCard(
                  section: widget.shop.sections[i],
                  updateTotalFoods: updateTotalFoods,
                  updateTotalPrice: updateTotalPrice,
                  updatePurchasedFoods: updatePurchasedFood,
                  foods: purchasedFoods,
                ),

              //
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
                  "$totalFoods ${AppLocalizations.of(context)!.product}",
                  style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      color: Colors.white,
                      fontSize: 15),
                ),
                Text(
                  "$totalPriceĐ",
                  style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      color: Colors.white,
                      fontSize: 20),
                ),

                // Check out button
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => OrderScreen(
                                foods: purchasedFoods,
                                updateTotalFoods: updateTotalFoods,
                                updateTotalPrice: updateTotalPrice,
                                updatePurchasedFoods: updatePurchasedFood,
                                username: widget.username,
                                phoneNumber: widget.phoneNumber,
                                address: widget.address,
                                userCredential: widget.userCredential,
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
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
