import 'package:box/details/food_detail.dart';
import 'package:box/details/order_food_detail.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../class/food.dart';

class HorizontalFoodCard extends StatefulWidget {
  final Food food;
  final Function(int, bool) updateTotalFoods;
  final Function(Food, bool) updateTotalPrice;
  final Function(Food, bool) updatePurchasedFoods;
  final List<Food> foods;
  final List<String> favoriteFoods;
  final Function(Food, bool) updateFavoriteFoods;

  const HorizontalFoodCard(
      {super.key,
      required this.food,
      required this.updateTotalFoods,
      required this.updateTotalPrice,
      required this.updatePurchasedFoods,
      required this.foods,
      required this.favoriteFoods,
      required this.updateFavoriteFoods});

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
            favoriteFoods: widget.favoriteFoods,
            updateFavoriteFoods: widget.updateFavoriteFoods,
          ),
        ),
      );
    });
  }

  void _onPressDecrease() {
    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => OrderFoodDetail(
                  foods: widget.foods,
                  updateTotalFoods: widget.updateTotalFoods,
                  updateTotalPrice: widget.updateTotalPrice,
                  updatePurchasedFoods: widget.updatePurchasedFoods,
                  updateQuantity: updateQuantity,
                )),
      );
    });
  }

  int getNewQuantity(List<Food> foods, Food food) {
    int res = 0;

    for (Food curFood in foods) {
      if (curFood.foodId == food.foodId) {
        res += curFood.quantity;
      }
    }

    return res;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      quantity = widget.food.quantity;
    });
  }

  @override
  void didUpdateWidget(covariant HorizontalFoodCard oldWidget) {
    int newQuantity = getNewQuantity(widget.foods, widget.food);
    if (newQuantity != oldWidget.food.quantity) {
      setState(() {
        quantity = newQuantity;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            // Food Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10), 
              child: Image.network(
                widget.food.foodImage,
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              ),
            ),

            //
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Comfortaa', fontSize: 17),
                    ),
                  ),

                  //
                  const SizedBox(
                    height: 10,
                  ),

                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Price
                      Text(
                        "${NumberFormat.decimalPattern().format(widget.food.foodPrice).replaceAll(',', '.')}Đ",
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
