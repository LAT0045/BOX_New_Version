import 'package:box/cards/order_food_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import '../utils/colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
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
                          onTap: () {},
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
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: OrderFoodCard(),
                      );
                    }),
              ),
            ]),
          ),

          // Check out button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
                onPressed: () {},
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
