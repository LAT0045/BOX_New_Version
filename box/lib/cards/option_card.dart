import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class OptionCard extends StatelessWidget {
  final String name;
  final String price;

  const OptionCard({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 170,
              child:Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Comfortaa',
                  //color: AppColors.orangeColor,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            

            SizedBox(
              width: 150,
              height: 40,
              child:Align(
                alignment: Alignment.centerRight,
                child:Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child:Text(
                    price,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Comfortaa',
                    //color: AppColors.orangeColor,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ),
            ),
            

            RoundCheckBox(
              onTap: (selected) {},
              uncheckedColor: AppColors.lightGrayColor,
              size: 30,
              checkedColor: AppColors.orangeColor,
            ),

          ],
        ),
      );
  }
  
  void setState(Null Function() param0) {}
}
