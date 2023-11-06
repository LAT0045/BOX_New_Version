import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class SettingDetailScreen extends StatelessWidget {
  const SettingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: onPressedBackBtn,
                      child: SvgPicture.asset(
                        "assets/svg/backarrow.svg",
                        width: 40,
                        height: 40,
                        colorFilter: const ColorFilter.mode(
                          AppColors.orangeColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 90,
                  ),

                  const Text(
                    "Cài đặt",
                    style: TextStyle(
                      color: AppColors.orangeColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ],
              ),
            ),

            //const SizedBox(height: 20),
 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child:TextButton(
                  onPressed: onPressedLanguageBtn,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        "Ngôn Ngữ",
                        style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Comfortaa',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                      ),
                      
                      SizedBox(height: 10),

                      Text(
                        "Tiếng Việt",
                        style: TextStyle(
                        color: AppColors.grayColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                      )
                    ]
                  ), 
                )
              )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child:TextButton(
                  onPressed: onPressedLanguageBtn,
                  child: const Text(
                    "Đổi Mật Khẩu",
                    style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                ), 
              )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child:TextButton(
                  onPressed: onPressedLanguageBtn,
                  child: const Text(
                    "Điều khoản",
                    style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                ), 
              )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child:TextButton(
                  onPressed: onPressedLanguageBtn,
                  child: const Text(
                    "Trợ giúp",
                    style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                ), 
              )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child:TextButton(
                  onPressed: onPressedLanguageBtn,
                  child: const Text(
                    "Xóa Tài Khoản",
                    style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                ), 
              )
            ),



        ],)
      ),
    );
  }

  //--------------------------------------------
  // Functions
  void onPressedBackBtn(){}
  void onPressedLanguageBtn(){}
}
