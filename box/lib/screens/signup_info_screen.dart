import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class SignUpInfoScreen extends StatelessWidget {
  const SignUpInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SizedBox(
            height: 80,
          ),

          // Name input
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.orangeColor,
                )),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.orangeColor),
                ),
                hintText: "Tên của bạn là gì?",
              ),
              cursorColor: AppColors.orangeColor,
              style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          // address input
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.orangeColor,
                )),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.orangeColor),
                ),
                hintText: "Địa chỉ nè",
              ),
              cursorColor: AppColors.orangeColor,
              style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
              obscureText: true,
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          //Avatar Text
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 45.0),
              child: Text(
              "Ảnh đại diện",
              style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold,)
              ),
            ) 
          ),

          const SizedBox(
            height: 50,
          ),

          //Avatar Picture
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/svg/avatest.jpg"),
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),
          
          //Choose Avatar
          TextButton(
            onPressed: onPressedChooseAva,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.blueColor,
            ),
            child: const Text(
              "Chọn Ảnh",
              style: TextStyle(fontFamily: 'Comfortaa', fontSize: 21, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          // Update button
          Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                gradient: const LinearGradient(
                  colors: [AppColors.orangeColor, AppColors.yellowColor],
                )),
            child: TextButton(
              onPressed: onPressedUpdate,
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shadowColor: Colors.transparent),
              child: const Text(
                "Cập Nhật",
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 30,
          ),     
        ]),
      ),
    );
  }

  //--------------------------------------------
  // Functions
  void onPressedUpdate(){}
  void onPressedChooseAva(){}
}
