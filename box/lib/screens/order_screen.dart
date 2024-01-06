import 'package:box/cards/order_food_card.dart';
import 'package:box/details/check_out_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import '../class/food.dart';
import '../utils/colors.dart';

class OrderScreen extends StatefulWidget {
  final List<Food> foods;
  final Function(int, bool) updateTotalFoods;
  final Function(Food, bool) updateTotalPrice;
  final Function(Food, bool) updatePurchasedFoods;
  final String username;
  final String phoneNumber;
  final String address;
  final String shopAddress;
  final String shopId;
  final UserCredential userCredential;

  const OrderScreen(
      {super.key,
      required this.foods,
      required this.updateTotalFoods,
      required this.updateTotalPrice,
      required this.updatePurchasedFoods,
      required this.username,
      required this.phoneNumber,
      required this.address,
      required this.shopAddress,
      required this.shopId,
      required this.userCredential});

  @override
  State<StatefulWidget> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  void updateQuantity(int value, bool isRemoved) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Column(children: [
              // Return button and title
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
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.order,
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

              // Items
              Expanded(
                child: ListView.builder(
                    itemCount: widget.foods.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OrderFoodCard(
                              food: widget.foods[index],
                              updateTotalFoods: widget.updateTotalFoods,
                              updateTotalPrice: widget.updateTotalPrice,
                              updatePurchasedFoods: widget.updatePurchasedFoods,
                              updateQuantity: updateQuantity));
                    }),
              ),
            ]),
          ),

          // Check out button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => CheckOutDetail(
                              foods: widget.foods,
                              username: widget.username,
                              phoneNumber: widget.phoneNumber,
                              address: widget.address,
                              userCredential: widget.userCredential,
                              shopAddress: widget.shopAddress,
                              shopId: widget.shopId,
                            )),
                  );
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: AppColors.mediumOrangeColor),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.checkOut,
                    style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
          )
        ],
      )),
    );
  }
}

class EmptyOrderScreen extends StatelessWidget {
  const EmptyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            AppLocalizations.of(context)!.favoriteDishes,
            style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ),
        ),
        Lottie.asset("assets/anim/shake_empty_box.json"),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Text(
            "Opps!!!",
            style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.orderEmpty,
          style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 20,
              color: AppColors.grayColor),
        ),
        const SizedBox(
          height: 30,
        ),

        // Check out
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.mediumOrangeColor),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.addDish,
                    style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
