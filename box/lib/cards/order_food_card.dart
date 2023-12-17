import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../class/food.dart';
import '../class/option.dart';
import '../class/option_detail.dart';
import '../utils/colors.dart';
import 'package:intl/intl.dart';

class OrderFoodCard extends StatefulWidget {
  final Food food;
  final Function(int, bool) updateTotalFoods;
  final Function(Food, bool) updateTotalPrice;
  final Function(Food, bool) updatePurchasedFoods;
  final Function(int, bool) updateQuantity;

  const OrderFoodCard({
    super.key,
    required this.food,
    required this.updateTotalFoods,
    required this.updateTotalPrice,
    required this.updatePurchasedFoods,
    required this.updateQuantity,
  });

  @override
  State<StatefulWidget> createState() {
    return _OrderFoodCardState();
  }
}

class _OrderFoodCardState extends State<OrderFoodCard> {
  int _quantity = 0;
  int _totalFoodPrice = 0;

  void _onPressIncrease() {
    setState(() {
      _quantity++;
      widget.updateTotalFoods(1, false);
      widget.updateTotalPrice(widget.food, false);
      widget.updatePurchasedFoods(widget.food, false);
      widget.updateQuantity(1, false);
      _totalFoodPrice += calculateTotalPrice(widget.food);
    });
  }

  void _onPressDecrease() {
    setState(() {
      _quantity--;
      widget.updateTotalFoods(1, true);
      widget.updateTotalPrice(widget.food, true);
      widget.updatePurchasedFoods(widget.food, true);
      widget.updateQuantity(1, true);
      _totalFoodPrice -= calculateTotalPrice(widget.food);
    });
  }

  int calculateTotalPrice(Food food) {
    int res = food.foodPrice;

    for (Option option in food.options) {
      res += calculateOptionDetail(option.optionList);
    }

    return res;
  }

  int calculateOptionDetail(List<OptionDetail> optionDetails) {
    int res = 0;

    for (OptionDetail optionDetail in optionDetails) {
      res += optionDetail.price;
    }

    return res;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _quantity = widget.food.quantity;
      _totalFoodPrice = calculateTotalPrice(widget.food) * _quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                width: 210,
                child: Text(
                  widget.food.foodName,
                  style: const TextStyle(fontFamily: 'Comfortaa', fontSize: 17),
                ),
              ),

              // Food price
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: SizedBox(
                  width: 210,
                  child: Text(
                    "${NumberFormat.decimalPattern().format(_totalFoodPrice).replaceAll(',', '.').toString()}Đ",
                    style:
                        const TextStyle(fontFamily: 'Comfortaa', fontSize: 17),
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
                      for (int i = 0; i < widget.food.options.length; i++)
                        //Add
                        SizedBox(
                            width: 210,
                            child: Text(
                              "${widget.food.options[i].optionName}: ${widget.food.options[i].optionList.map((optionDetail) => optionDetail.name).join(', ')}",
                              style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  color: Colors.grey[600]),
                            )),

                      //Note
                      SizedBox(
                          width: 210,
                          child: Text(
                            "${AppLocalizations.of(context)!.note}: ${widget.food.foodNote}",
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
