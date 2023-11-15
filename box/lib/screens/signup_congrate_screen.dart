import 'package:box/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class SignUpCongrateScreen extends StatefulWidget {

  @override
  State<SignUpCongrateScreen> createState() => _SignUpCongrateScreenState();
}

class _SignUpCongrateScreenState extends State<SignUpCongrateScreen> {
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

          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
              child: Text(
              "Chúc mừng bạn đã đăng ký tài khoản thành công. Bây giờ chúng ta cùng trải nghiệm BOX nào.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa', color: AppColors.orangeColor,)
              ),
            ), 


          const SizedBox(
            height: 40,
          ),  

          SvgPicture.asset(
            "assets/svg/congrate.svg",
            width: 200,
            height: 200,
          ),

          const SizedBox(
            height: 70,
          ),  


          // Start button
          Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                gradient: const LinearGradient(
                  colors: [AppColors.orangeColor, AppColors.yellowColor],
                )),
            child: TextButton(
              onPressed: onPressedStart,
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shadowColor: Colors.transparent),
              child: const Text(
                "Bắt Đầu Thôi",
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
  void onPressedStart(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
