import 'package:box/cards/option_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../class/food.dart';
import '../class/option_detail.dart';
import '../utils/colors.dart';

class FoodDetail extends StatefulWidget {
  final Food food;
  final Function(int, bool) updateTotalFoods;
  final Function(Food, bool) updateTotalPrice;
  final Function(Food, bool) updatePurchasedFoods;
  final Function(int, bool) updateQuantity;

  const FoodDetail(
      {super.key,
      required this.food,
      required this.updateTotalFoods,
      required this.updateTotalPrice,
      required this.updatePurchasedFoods,
      required this.updateQuantity});

  @override
  State<StatefulWidget> createState() {
    return _FoodDetailState();
  }
}

class _FoodDetailState extends State<FoodDetail> {
  Food chosenFood = Food.empty();
  TextEditingController textEditingController = TextEditingController();

  void updateOptions(OptionDetail optionDetail, bool isRemoved, bool isOptional,
      String optionName) {
    setState(() {
      for (int i = 0; i < chosenFood.options.length; i++) {
        if (chosenFood.options[i].optionName == optionName) {
          if (isOptional) {
            if (isRemoved) {
              chosenFood.options[i].optionList
                  .removeWhere((element) => element.name == optionDetail.name);
            } else {
              chosenFood.options[i].addToOptionList(optionDetail);
            }
          } else {
            if (isRemoved) {
              chosenFood.options[i].optionList = [];
            } else {
              chosenFood.options[i].optionList = [];
              chosenFood.options[i].addToOptionList(optionDetail);
            }
          }
        }
      }
    });
  }

  void addFoodToCart() {
    chosenFood.updateQuantity(1, false);
    String note = textEditingController.text;
    chosenFood.foodNote = note;

    widget.updateTotalFoods(1, false);
    widget.updatePurchasedFoods(chosenFood, false);
    widget.updateQuantity(1, false);
    widget.updateTotalPrice(chosenFood, false);

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    chosenFood = Food.copy(widget.food);

    for (int i = 0; i < chosenFood.options.length; i++) {
      chosenFood.options[i].optionList = [];
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Stack(
            children: [
              // Food image
              Image.network(
                widget.food.foodImage,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              // Close button
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close_outlined,
                ),
                iconSize: 40,
                color: AppColors.orangeColor,
              ),
            ],
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
              child: OptionCard(
                  option: widget.food.options[i], updateOptions: updateOptions),
            ),

          //
          const SizedBox(
            height: 20,
          ),

          // Note
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                AppLocalizations.of(context)!.note,
                style: const TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 18,
                    color: AppColors.orangeColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Input note
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[200]),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.noteAsk,
                  border: InputBorder.none, // Remove the border
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
          ),

          // Add button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
                onPressed: () {
                  addFoodToCart();
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: AppColors.mediumOrangeColor),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.addToCart,
                    style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
          ),

          //
          const SizedBox(
            height: 10,
          )
        ],
      ))),
    );
  }
}
