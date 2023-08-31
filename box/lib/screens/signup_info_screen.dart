import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/colors.dart';

class SignUpInfoScreen extends StatelessWidget {
  const SignUpInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: GestureDetector(
                onTap: onPressedBackBtn,
                child: SvgPicture.asset(
                  "assets/svg/backarrow.svg",
                  width: 50,
                  height: 50,
                  colorFilter: const ColorFilter.mode(
                      AppColors.orangeColor, BlendMode.srcIn),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 40,
          ),

          // Name input
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
                hintText: AppLocalizations.of(context)!.nameAsking,
              ),
              cursorColor: AppColors.orangeColor,
              style: const TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          // address input
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
                hintText: AppLocalizations.of(context)!.address,
              ),
              cursorColor: AppColors.orangeColor,
              style: const TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
              obscureText: true,
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          //Avatar Text
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 45.0),
                child: Text(AppLocalizations.of(context)!.avatar,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                    )),
              )),

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
            child: Text(
              AppLocalizations.of(context)!.selectImage,
              style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          // Update button
          Container(
            width: 180,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                gradient: const LinearGradient(
                  colors: [AppColors.orangeColor, AppColors.yellowColor],
                )),
            child: TextButton(
              onPressed: onPressedUpdate,
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shadowColor: Colors.transparent),
              child: Text(
                AppLocalizations.of(context)!.update,
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
        ]),
      ),
    );
  }

  //--------------------------------------------
  // Functions
  void onPressedUpdate() {}
  void onPressedChooseAva() {}
  void onPressedBackBtn() {}
}
