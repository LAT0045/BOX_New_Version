import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onPressedForgot() {
    //TODO: Thêm hàm quên mật khẩu
  }

  void _onPressedLogin() {
    //TODO: Thêm hàm đăng nhập
  }

  void _onPressedFacebook() {
    //TODO: Thêm hàm đăng nhập bằng Facebook
  }

  void _onPressedGmail() {
    //TODO: Thêm hàm đăng nhập bằng Gmail
  }

  void _onPressedSignUp() {
    //TODO: Thêm hàm chuyển sang trang đăng ký
  }

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
            height: 20,
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
            height: 10,
          ),

          // Forgot password button
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: TextButton(
                onPressed: _onPressedForgot,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.orangeColor,
                ),
                child: const Text(
                  "Quên mật khẩu?",
                  style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // Login button
          Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                gradient: const LinearGradient(
                  colors: [AppColors.orangeColor, AppColors.yellowColor],
                )),
            child: TextButton(
              onPressed: _onPressedLogin,
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shadowColor: Colors.transparent),
              child: const Text(
                "Đăng Nhập",
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

          // Divider
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: AppColors.orangeColor,
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Hoặc",
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: AppColors.orangeColor),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: AppColors.orangeColor,
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          // Facebook button
          TextButton.icon(
              onPressed: _onPressedFacebook,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.lightGrayColor,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              icon: SvgPicture.asset(
                "assets/svg/facebook_icon.svg",
                width: 20,
                height: 20,
              ),
              label: const SizedBox(
                width: 260,
                child: Text(
                  "Đăng Nhập Bằng Facebook",
                  style: TextStyle(
                      color: AppColors.orangeColor,
                      fontFamily: 'Comfortaa',
                      fontSize: 18),
                ),
              )),

          const SizedBox(
            height: 10,
          ),

          // Gmail button
          TextButton.icon(
              onPressed: _onPressedGmail,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.lightGrayColor,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              icon: SvgPicture.asset(
                "assets/svg/gmail_icon.svg",
                width: 20,
                height: 20,
              ),
              label: const SizedBox(
                width: 260,
                child: Text(
                  "Đăng Nhập Bằng Gmail",
                  style: TextStyle(
                      color: AppColors.orangeColor,
                      fontFamily: 'Comfortaa',
                      fontSize: 18),
                ),
              )),

          const SizedBox(
            height: 20,
          ),

          // Question and sign up button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Bạn chưa có tài khoản?",
                style: TextStyle(
                    color: AppColors.orangeColor,
                    fontFamily: 'Comfortaa',
                    fontSize: 15),
              ),
              TextButton(
                  onPressed: _onPressedSignUp,
                  child: const Text(
                    "Đăng Ký Ngay >>>>",
                    style: TextStyle(
                        color: AppColors.blueColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 15),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
