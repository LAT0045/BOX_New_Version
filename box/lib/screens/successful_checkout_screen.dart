import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/colors.dart';

class SuccessfulCheckoutScreen extends StatelessWidget {
  const SuccessfulCheckoutScreen({super.key});

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
          const Text(
            "Đã Đặt Hàng Thành Công",
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 90,
          ),

          // Check order button
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.mediumOrangeColor),
              child: const SizedBox(
                width: 150,
                child: Center(
                  child: Text(
                    "Xem Đơn Hàng",
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              )),

          const SizedBox(
            height: 10,
          ),

          // HomePage button
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                        width: 1, color: AppColors.mediumOrangeColor)),
              ),
              child: const SizedBox(
                width: 150,
                child: Center(
                  child: Text(
                    "Trang Chủ",
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: AppColors.mediumOrangeColor),
                  ),
                ),
              )),
        ],
      )),
    );
  }
}
