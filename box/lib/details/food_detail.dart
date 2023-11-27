import 'package:box/cards/option_card.dart';
import 'package:flutter/material.dart';

import '../class/food.dart';

class FoodDetail extends StatefulWidget {
  final Food food;

  const FoodDetail({super.key, required this.food});

  @override
  State<StatefulWidget> createState() {
    return _FoodDetailState();
  }
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          // Food image
          Image.network(
            widget.food.foodImage,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          //
          const SizedBox(
            height: 20,
          ),

          //Name and price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    widget.food.foodName,
                    style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                //
                Text(
                  "${widget.food.foodPrice.toString()}Đ",
                  style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          //
          const SizedBox(
            height: 20,
          ),

          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                widget.food.foodDescription,
                style: const TextStyle(
                    fontFamily: 'Comfortaa', fontSize: 15, color: Colors.grey),
              ),
            ),
          ),

          // Options
          for (int i = 0; i < widget.food.options.length; i++)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: OptionCard(option: widget.food.options[i]),
            )
        ],
      ))),
    );
  }
}
