import 'package:box/utils/colors.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VoucherCard extends StatelessWidget {
  const VoucherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          // Shop Image
          Container(
            decoration: DottedDecoration(
                shape: Shape.line,
                linePosition: LinePosition.right,
                color: AppColors.grayColor),
            width: 100,
            height: 80,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/test/milano_coffee.jpg'),
                ),
              ],
            ),
          ),

          // Information
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: 190,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Voucher info
                  const Text(
                    "Giảm 20%",
                    style: TextStyle(fontFamily: 'Comfortaa', fontSize: 18),
                  ),

                  // Condition
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Đơn tối thiểu 50.000Đ",
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 15,
                      ),
                    ),
                  ),

                  // Expiration date
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/clock.svg",
                        width: 10,
                        height: 10,
                        colorFilter:
                            const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Hết hạn: 20/08/2023",
                        style: TextStyle(
                            fontFamily: 'Comfortaa', color: Colors.red),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          // Save button
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.orangeColor),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Text(
                "Lưu",
                style: TextStyle(
                    fontFamily: 'Comfortaa', color: AppColors.orangeColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
