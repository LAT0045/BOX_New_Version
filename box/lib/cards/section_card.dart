import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';

import '../class/food.dart';
import '../class/section.dart';
import 'horizontal_food_card.dart';

class SectionCard extends StatefulWidget {
  final Section section;
  final Function(int, bool) updateTotalFoods;
  final Function(Food, bool) updateTotalPrice;
  final Function(Food, bool) updatePurchasedFoods;
  final List<Food> foods;
  final List<String> favoriteFoods;
  final Function(Food, bool) updateFavoriteFoods;

  const SectionCard(
      {super.key,
      required this.section,
      required this.updateTotalFoods,
      required this.updateTotalPrice,
      required this.updatePurchasedFoods,
      required this.foods,
      required this.favoriteFoods,
      required this.updateFavoriteFoods});

  @override
  State<SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.section.sectionName,
              style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.orangeColor),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        for (int i = 0; i < widget.section.foods.length; i++)
          HorizontalFoodCard(
            food: widget.section.foods[i],
            updateTotalFoods: widget.updateTotalFoods,
            updateTotalPrice: widget.updateTotalPrice,
            updatePurchasedFoods: widget.updatePurchasedFoods,
            foods: widget.foods,
            favoriteFoods: widget.favoriteFoods,
            updateFavoriteFoods: widget.updateFavoriteFoods,
          ),
      ],
    );
  }
}
