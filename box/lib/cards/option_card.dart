import 'package:box/class/option_detail.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../class/option.dart';

class OptionCard extends StatefulWidget {
  final Option option;
  final Function(OptionDetail, bool, bool, String) updateOptions;

  const OptionCard(
      {super.key, required this.option, required this.updateOptions});

  @override
  State<StatefulWidget> createState() {
    return _OptionCardState();
  }
}

class _OptionCardState extends State<OptionCard> {
  int chosenOptionIndex = -1;
  late Option option;

  void handleChoosingOption(int i) {
    setState(() {
      if (widget.option.optionType == "optional") {
        option.optionList[i].isChosen = !option.optionList[i].isChosen;

        if (option.optionList[i].isChosen) {
          // Add option
          widget.updateOptions(
              option.optionList[i], false, true, option.optionName);
        } else {
          // Remove option
          widget.updateOptions(
              option.optionList[i], true, true, option.optionName);
        }
      } else {
        // Deselect previous chosen option
        if (chosenOptionIndex != -1) {
          option.optionList[chosenOptionIndex].isChosen = false;
        }

        // Check if current chosen option is the same as previous
        if (chosenOptionIndex != i) {
          // If not set to true
          option.optionList[i].isChosen = true;
          chosenOptionIndex = i;

          // Add option
          widget.updateOptions(
              option.optionList[i], false, false, option.optionName);
        } else {
          // If it is, keep it as false (deselect), reset chosen index
          chosenOptionIndex = -1;

          // Remove option
          widget.updateOptions(
              option.optionList[i], true, false, option.optionName);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      chosenOptionIndex = -1;
      option = widget.option;
      for (int i = 0; i < option.optionList.length; i++) {
        option.optionList[i].isChosen = false;
      }
    });
  }

  @override
  void dispose() {
    setState(() {
      chosenOptionIndex = -1;
      for (int i = 0; i < option.optionList.length; i++) {
        option.optionList[i].isChosen = false;
      }
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          // Option name
          SizedBox(
              width: double.infinity,
              child: Text(
                option.optionName,
                style: const TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 18,
                    color: AppColors.orangeColor,
                    fontWeight: FontWeight.bold),
              )),

          // Option details
          for (int i = 0; i < option.optionList.length; i++)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Text(
                    option.optionList[i].name,
                    style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  //
                  Row(
                    children: [
                      Text(
                        "${NumberFormat.decimalPattern().format(option.optionList[i].price).replaceAll(',', '.')}Đ",
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
                            color: option.optionList[i].isChosen
                                ? AppColors.orangeColor
                                : Colors.grey[350],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
