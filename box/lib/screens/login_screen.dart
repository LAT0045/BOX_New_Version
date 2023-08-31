import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.orangeColor,
                )),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.orangeColor),
                ),
                hintText: AppLocalizations.of(context)!.email,
              ),
              cursorColor: AppColors.orangeColor,
              style: const TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // Password input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.orangeColor,
                )),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.orangeColor),
                ),
                hintText: AppLocalizations.of(context)!.password,
              ),
              cursorColor: AppColors.orangeColor,
              style: const TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
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
                child: Text(
                  AppLocalizations.of(context)!.forgotPassword,
                  style: const TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // Login button
          Container(
            width: 180,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                gradient: const LinearGradient(
                  colors: [AppColors.orangeColor, AppColors.yellowColor],
                )),
            child: TextButton(
              onPressed: _onPressedLogin,
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shadowColor: Colors.transparent),
              child: Text(
                AppLocalizations.of(context)!.signIn,
                style: const TextStyle(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Expanded(
                  child: Divider(
                    thickness: 1,
                    color: AppColors.orangeColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    AppLocalizations.of(context)!.or,
                    style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: AppColors.orangeColor),
                  ),
                ),
                const Expanded(
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
              label: SizedBox(
                width: 260,
                child: Text(
                  AppLocalizations.of(context)!.signInFacebook,
                  style: const TextStyle(
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
              label: SizedBox(
                width: 260,
                child: Text(
                  AppLocalizations.of(context)!.signInGmail,
                  style: const TextStyle(
                      color: AppColors.orangeColor,
                      fontFamily: 'Comfortaa',
                      fontSize: 18),
                ),
              )),

          const SizedBox(
            height: 20,
          ),

          // Question and sign up button
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.noAccount,
                style: const TextStyle(
                    color: AppColors.orangeColor,
                    fontFamily: 'Comfortaa',
                    fontSize: 15),
              ),
              TextButton(
                  onPressed: _onPressedSignUp,
                  child: Text(
                    AppLocalizations.of(context)!.signUpNow,
                    style: const TextStyle(
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
