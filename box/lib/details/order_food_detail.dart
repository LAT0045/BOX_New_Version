import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../cards/order_food_card.dart';
import '../class/food.dart';
import '../utils/colors.dart';

class OrderFoodDetail extends StatefulWidget {
  final List<Food> foods;
  final Function(int, bool) updateTotalFoods;
  final Function(Food, bool) updateTotalPrice;
  final Function(Food, bool) updatePurchasedFoods;
  final Function(int, bool) updateQuantity;

  const OrderFoodDetail(
      {super.key,
      required this.foods,
      required this.updateTotalFoods,
      required this.updateTotalPrice,
      required this.updatePurchasedFoods,
      required this.updateQuantity});

  @override
  State<StatefulWidget> createState() {
    return _OrderFoodDetailState();
  }
}

class _OrderFoodDetailState extends State<OrderFoodDetail> {
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
                          AppLocalizations.of(context)!.cart,
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
                          updateQuantity: widget.updateQuantity,
                        ),
                      );
                    }),
              ),
            ]),
          ),
        ],
      )),
    );
  }
}