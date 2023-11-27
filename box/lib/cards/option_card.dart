import 'package:box/class/option_detail.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';

import '../class/option.dart';

class OptionCard extends StatefulWidget {
  final Option option;

  const OptionCard({super.key, required this.option});

  @override
  State<StatefulWidget> createState() {
    return _OptionCardState();
  }
}

class _OptionCardState extends State<OptionCard> {
  List<OptionDetail> chosenOptions = [];
  OptionDetail chosenOption = OptionDetail("", "", false, 0, false);
  int chosenOptionIndex = -1;

  void handleChoosingOption(int i) {
    if (widget.option.optionType == "optional") {
      setState(() {
        widget.option.optionList[i].isChosen =
            !widget.option.optionList[i].isChosen;
      });
    } else {
      setState(() {
        // Deselect previous chosen option
        if (chosenOptionIndex != -1) {
          widget.option.optionList[chosenOptionIndex].isChosen = false;
        }

        // Check if current chosen option is the same as previous
        if (chosenOptionIndex != i) {
          // If not set to true
          widget.option.optionList[i].isChosen = true;
          chosenOptionIndex = i;
        } else {
          // If it is, deselect it, reset chosen index
          chosenOptionIndex = -1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Text(
                widget.option.optionName,
                style: const TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 18,
                    color: AppColors.orangeColor,
                    fontWeight: FontWeight.bold),
              )),

          //
          for (int i = 0; i < widget.option.optionList.length; i++)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Text(
                    widget.option.optionList[i].name,
                    style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  //
                  Row(
                    children: [
                      Text(
                        "${widget.option.optionList[i].price.toString()}Đ",
                        style: const TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      //
                      GestureDetector(
                        onTap: () {
                          handleChoosingOption(i);
                        },
                        child: ClipOval(
                          child: Container(
                            width: 20,
                            height: 20,
                            color: widget.option.optionList[i].isChosen
                                ? AppColors.orangeColor
                                : Colors.grey[350],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
