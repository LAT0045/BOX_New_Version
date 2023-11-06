import 'package:box/cards/favorite_food_card.dart';
import 'package:box/cards/option_card.dart';
import 'package:box/cards/section_card.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ToppingCard extends StatefulWidget {
  final bool isObg;
  final String toppingName;

  const ToppingCard({Key? key, required this.isObg, required this.toppingName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ToppingCardState();
  }
}

class _ToppingCardState extends State<ToppingCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: widget.isObg
            ? ObgToppingCard(toppingName: widget.toppingName)
            : NotObgToppingCard(toppingName: widget.toppingName));
  }
}

class ObgToppingCard extends StatelessWidget {
  final String toppingName;
  const ObgToppingCard({super.key, required this.toppingName});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              toppingName,
              style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: AppColors.orangeColor),
            ),
          ),
        ),
        Flexible(
              child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
              return const OptionCard(name: 'Size S', price: '59000',);
            }
          ),
        )
      ],
    );
  }
 
}


class NotObgToppingCard extends StatelessWidget {
  final String toppingName;
  const NotObgToppingCard({super.key, required this.toppingName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              toppingName,
              style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: AppColors.orangeColor),
            ),
          ),
        ),
        Flexible(
              child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
              return const OptionCard(name: 'Size S', price: '59000',);
            }
          ),
        )
      ],
    );
  }
}
