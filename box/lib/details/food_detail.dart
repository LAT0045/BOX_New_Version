import 'package:box/cards/section_card.dart';
import 'package:box/cards/topping_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cards/option_card.dart';
import '../utils/colors.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
      
            child: Column(children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/test/milano_coffee.jpg',
                    width: 500,
                    height: 150,
                    fit: BoxFit.fill,
                  ),
      
                  Positioned(
                    top: 5,
                    left: 15,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        "assets/svg/x.svg",
                        height: 50,
                        width: 50,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                      ),
                      onPressed: onPressedCancelBtn
                    )
                  )
                ],
              ),
      
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 230,
                      child:Text(
                        "Phô Mai Việt Quất Đá Xay",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    
      
                    SizedBox(
                      width: 120,
                      height: 40,
                      child:Align(
                        alignment: Alignment.centerRight,
                        child:Text(
                            "59.000 Đ",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold
                            ),
                          ),
                      ),
                    ),
                  ],)
                ),
      
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                      child: Text(
                        "Phô Mai và Việt Quất kết hợp tạo nên một món đá xay thơm ngon vào những ngày oi bức.",
                          style: TextStyle(
                          color: AppColors.grayColor,
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                        ),
                      ), 
                  )
                ),

                const SizedBox(height: 20,),

                //const SectionCard(sectionName: 'Chọn size', widgets: [OptionCard(name: 'Size S', price: '0Đ',),OptionCard(name: 'Size S', price: '0Đ',),OptionCard(name: 'Size S', price: '0Đ',)]),                
              
                Container(
                  height: 300,
                  child: const ToppingCard(isObg: false, toppingName: 'Chọn Size'))
                      
            ],)
          ),
        ),
      ),
    );
  }
}

//--------------------------------------------
  // Functions
  void onPressedCancelBtn(){}



