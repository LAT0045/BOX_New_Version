import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodCard extends StatelessWidget {
  static const int salesFood = 0;
  static const int forYouFood = 1;

  final int type;

  const FoodCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [const SoldItemProgress(), const ForYou()];

    return Card(
      color: const Color(0xFFF7F7F7),
      elevation: 1,
      child: Column(
        children: [
          Image.asset(
            'assets/test/milano_coffee.jpg',
            width: 120,
            height: 90,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            width: 120,
            child: Text(
              "Cà Phê Kem Trứng",
              style: TextStyle(fontFamily: 'Comfortaa'),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            width: 120,
            child: Text(
              "25.000Đ",
              style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          widgets[type],
        ],
      ),
    );
  }
}

class SoldItemProgress extends StatelessWidget {
  const SoldItemProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(children: [
      SizedBox(
        width: 100,
        height: 15,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: LinearProgressIndicator(
            value: 0.5,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.orangeColor),
            backgroundColor: AppColors.lightOrangeColor,
          ),
        ),
      ),
      SizedBox(
        width: 100,
        height: 15,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Đã bán 10",
            style: TextStyle(
                fontFamily: 'Comfortaa', fontSize: 12, color: Colors.white),
          ),
        ),
      )
    ]);
  }
}

class ForYou extends StatelessWidget {
  const ForYou({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/voucher.svg",
            height: 22,
            width: 22,
            colorFilter:
                const ColorFilter.mode(AppColors.orangeColor, BlendMode.srcIn),
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
            "Mã giảm 20%",
            style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 12,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}