import 'package:box/screens/home_screen.dart';
import 'package:box/tabs/order_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/colors.dart';

class SuccessfulOrderScreen extends StatelessWidget {
  final UserCredential userCredential;
  final String address;
  final bool status;

  const SuccessfulOrderScreen({
    Key? key,
    required this.userCredential,
    required this.address,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String yahooText = status ? "Cảm ơn bạn vì đã đặt hàng" : "Có sự nhầm lẫn gì sao?";
    String animationPath = status ? "assets/anim/congratulations.json" : "assets/anim/sad.json";

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              yahooText,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.orangeColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Lottie.asset(
                animationPath,
                height: 300,
                width: 300,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              status
                  ? "Hi vọng bạn đã có một trải nghiệm tuyệt vời"
                  : "Xin lỗi bạn vì trải nghiệm không tốt!",
              style: const TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        userCredential: userCredential,
                        address: address,
                      ),
                    ),
                  );
                },
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
                      AppLocalizations.of(context)!.homePage,
                      style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}