import 'package:box/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/colors.dart';

class SuccessfulCheckoutScreen extends StatelessWidget {
  final UserCredential userCredential;
  final String address;

  const SuccessfulCheckoutScreen(
      {super.key, required this.userCredential, required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          // Yahoo text
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Yahoo!!!!",
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          // Animation
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Lottie.asset("assets/anim/congratulations.json",
                height: 300, width: 300),
          ),

          const SizedBox(
            height: 40,
          ),

          // Inform text
          Text(
            AppLocalizations.of(context)!.orderSuccessfully,
            style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 90,
          ),

          // Check order button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: AppColors.mediumOrangeColor),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.viewOrder,
                      style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                )),
          ),

          const SizedBox(
            height: 10,
          ),

          // HomePage button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                            userCredential: userCredential, address: address)),
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                          width: 1, color: AppColors.mediumOrangeColor)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.homePage,
                      style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          color: AppColors.mediumOrangeColor),
                    ),
                  ),
                )),
          ),
        ],
      )),
    );
  }
}
