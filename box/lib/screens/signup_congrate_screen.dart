import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/colors.dart';

class SignUpCongrateScreen extends StatelessWidget {
  const SignUpCongrateScreen({super.key});

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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Text(AppLocalizations.of(context)!.congratulation,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Comfortaa',
                  color: AppColors.orangeColor,
                )),
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
            width: 230,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                gradient: const LinearGradient(
                  colors: [AppColors.orangeColor, AppColors.yellowColor],
                )),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shadowColor: Colors.transparent),
              child: Text(
                AppLocalizations.of(context)!.getStarted,
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
}
