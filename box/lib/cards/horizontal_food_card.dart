import 'package:box/details/food_detail.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';

import '../class/food.dart';

class HorizontalFoodCard extends StatefulWidget {
  final Food food;
  final Function(int, bool) updateTotalFoods;
  final Function(int, bool) updateTotalPrice;
  final Function(Food, bool) updatePurchasedFoods;

  const HorizontalFoodCard(
      {super.key,
      required this.food,
      required this.updateTotalFoods,
      required this.updateTotalPrice,
      required this.updatePurchasedFoods});

  @override
  State<StatefulWidget> createState() {
    return _HorizontalFoodCardState();
  }
}

class _HorizontalFoodCardState extends State<HorizontalFoodCard> {
  int quantity = 0;

  void _onPressIncrease() {
    setState(() {
      //quantity++;
      //widget.updateTotalFoods(1, false);
      //widget.updateTotalPrice(widget.food.foodPrice, false);
      //widget.updatePurchasedFoods(widget.food, false);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FoodDetail(
            food: widget.food,
          ),
        ),
      );
    });
  }

  void _onPressDecrease() {
    setState(() {
      quantity--;
      widget.updateTotalFoods(1, true);
      widget.updateTotalPrice(widget.food.foodPrice, true);
      widget.updatePurchasedFoods(widget.food, true);
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
