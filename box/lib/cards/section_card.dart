import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String sectionName;
  final List<Widget> widgets;

  const SectionCard(
      {super.key, required this.sectionName, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              sectionName,
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
        for (int i = 0; i < widgets.length; i++) widgets[i]
      ],
    );
  }
}
