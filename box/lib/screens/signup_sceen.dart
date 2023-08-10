import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),

          // Logo
          SvgPicture.asset(
            "assets/svg/logo.svg",
            width: 100,
            height: 100,
          ),

          const SizedBox(
            height: 50,
          ),

          // Email input
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
                hintText: "Email",
              ),
              cursorColor: AppColors.orangeColor,
              style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          // Password input
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
                hintText: "Mật khẩu",
              ),
              cursorColor: AppColors.orangeColor,
              style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
              obscureText: true,
            ),
          ),

          const SizedBox(
            height: 18,
          ),

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
                hintText: "Nhập lại mật khẩu",
              ),
              cursorColor: AppColors.orangeColor,
              style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
              obscureText: true,
            ),
          ),

          const SizedBox(
            height: 80,
          ),
          
          // SignUp button
          Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                gradient: const LinearGradient(
                  colors: [AppColors.orangeColor, AppColors.yellowColor],
                )),
            child: TextButton(
              onPressed: onPressedSignUp,
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shadowColor: Colors.transparent),
              child: const Text(
                "Đăng ký",
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
  void onPressedSignUp(){}
}
