import 'package:box/details/food_detail.dart';
import 'package:box/details/order_food_detail.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';

import '../class/food.dart';

class HorizontalFoodCard extends StatefulWidget {
  final Food food;
  final Function(int, bool) updateTotalFoods;
  final Function(Food, bool) updateTotalPrice;
  final Function(Food, bool) updatePurchasedFoods;
  final List<Food> foods;

  const HorizontalFoodCard(
      {super.key,
      required this.food,
      required this.updateTotalFoods,
      required this.updateTotalPrice,
      required this.updatePurchasedFoods,
      required this.foods});

  @override
  State<StatefulWidget> createState() {
    return _HorizontalFoodCardState();
  }
}

class _HorizontalFoodCardState extends State<HorizontalFoodCard> {
  int quantity = 0;

  void updateQuantity(int value, bool isDecreased) {
    if (isDecreased) {
      quantity -= value;
    } else {
      quantity += value;
    }
  }

  void _onPressIncrease() {
    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FoodDetail(
            food: widget.food,
            updateTotalFoods: widget.updateTotalFoods,
            updateTotalPrice: widget.updateTotalPrice,
            updatePurchasedFoods: widget.updatePurchasedFoods,
            updateQuantity: updateQuantity,
          ),
        ),
      );
    });
  }

  void _onPressDecrease() {
    setState(() {
      List<Food> foods = [];

      for (Food food in widget.foods) {
        if (food.foodId == widget.food.foodId) {
          foods.add(food);
        }
      }

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => OrderFoodDetail(
                  foods: foods,
                  updateTotalFoods: widget.updateTotalFoods,
                  updateTotalPrice: widget.updateTotalPrice,
                  updatePurchasedFoods: widget.updatePurchasedFoods,
                  updateQuantity: updateQuantity,
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            // Food Image
            Image.network(
              widget.food.foodImage,
              height: 80,
              width: 80,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 10,
            ),

            // Food Information
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      widget.food.foodName,
                      style: const TextStyle(
                          fontFamily: 'Comfortaa', fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Price
                      Text(
                        "${widget.food.foodPrice}Đ",
                        style: const TextStyle(
                            fontFamily: 'Comfortaa', fontSize: 17),
                      ),

                      Row(
                        children: [
                          //Decrease button
                          Visibility(
                            visible: quantity > 0,
                            child: GestureDetector(
                              onTap: _onPressDecrease,
                              child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: AppColors.orangeColor,
                                child: Icon(
                                  Icons.remove_outlined,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),

                          // Quantity
                          Visibility(
                            visible: quantity > 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                quantity.toString(),
                                style: const TextStyle(fontFamily: 'Comfortaa'),
                              ),
                            ),
                          ),

                          // Increase button
                          GestureDetector(
                            onTap: _onPressIncrease,
                            child: const CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColors.orangeColor,
                              child: Icon(
                                Icons.add_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
