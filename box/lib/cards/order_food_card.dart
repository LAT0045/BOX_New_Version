import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/colors.dart';

class OrderFoodCard extends StatefulWidget {
  const OrderFoodCard({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrderFoodCardState();
  }
}

class _OrderFoodCardState extends State<OrderFoodCard> {
  int _quantity = 0;

  void _onPressIncrease() {
    setState(() {
      _quantity++;
    });
  }

  void _onPressDecrease() {
    setState(() {
      _quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Food Image
        Image.asset(
          'assets/test/ca_phe_kem_trung.jpeg',
          height: 80,
          width: 80,
          fit: BoxFit.fill,
        ),

        const SizedBox(
          width: 10,
        ),

        //Food details
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food name
              const SizedBox(
                width: 200,
                child: Text(
                  "Cà Phê Kem Trứng",
                  style: TextStyle(fontFamily: 'Comfortaa', fontSize: 17),
                ),
              ),

              // Food price
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: SizedBox(
                  width: 200,
                  child: Text(
                    "25.000Đ",
                    style: TextStyle(fontFamily: 'Comfortaa', fontSize: 17),
                  ),
                ),
              ),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Topping and notes
                  Column(
                    children: [
                      //Add
                      SizedBox(
                          width: 180,
                          child: Text(
                            "${AppLocalizations.of(context)!.add}: topping 1, topping 2",
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                color: Colors.grey[600]),
                          )),

                      //Note
                      SizedBox(
                          width: 180,
                          child: Text(
                            "${AppLocalizations.of(context)!.note}: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                color: Colors.grey[600]),
                          ))
                    ],
                  ),

                  // Increase and decrease quantiy
                  Row(
                    children: [
                      //Decrease button
                      Visibility(
                        visible: _quantity > 0,
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
                        visible: _quantity > 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            _quantity.toString(),
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
              )
            ],
          ),
        )
      ],
    );
  }
}
