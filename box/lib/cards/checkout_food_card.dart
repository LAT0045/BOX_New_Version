import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../class/food.dart';
import '../class/option.dart';
import '../class/option_detail.dart';

class CheckOutFoodCard extends StatefulWidget {
  final Food food;

  const CheckOutFoodCard({super.key, required this.food});

  @override
  State<StatefulWidget> createState() {
    return _CheckOutFoodCardState();
  }
}

class _CheckOutFoodCardState extends State<CheckOutFoodCard> {
  int _quantity = 0;
  int _totalFoodPrice = 0;

  int calculateTotalPrice(Food food) {
    int res = food.foodPrice;

    for (Option option in food.options) {
      res += calculateOptionDetail(option.optionList);
    }

    res *= food.quantity;

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
      _totalFoodPrice = calculateTotalPrice(widget.food);
    });
  }

  @override
  void dispose() {
    setState(() {
      _quantity = 0;
      _totalFoodPrice = 0;
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    "${_totalFoodPrice.toString()}Đ",
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

                  // Quantity
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      _quantity.toString(),
                      style: const TextStyle(fontFamily: 'Comfortaa'),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}