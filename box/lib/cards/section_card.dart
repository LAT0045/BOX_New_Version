import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';

import '../class/section.dart';
import 'horizontal_food_card.dart';

class SectionCard extends StatelessWidget {
  final Section section;

  const SectionCard({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              section.sectionName,
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
        for (int i = 0; i < section.foods.length; i++)
          HorizontalFoodCard(
            food: section.foods[i],
          ),
      ],
    );
  }
}
