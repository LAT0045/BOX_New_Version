import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';

class HorizontalFoodCard extends StatefulWidget {
  HorizontalFoodCard({super.key});

  int _quantity = 0;

  @override
  State<StatefulWidget> createState() {
    return _HorizontalFoodCardState();
  }
}

class _HorizontalFoodCardState extends State<HorizontalFoodCard> {
  void _onPressIncrease() {
    setState(() {
      widget._quantity++;
    });
  }

  void _onPressDecrease() {
    setState(() {
      widget._quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            Image.asset(
              'assets/test/ca_phe_kem_trung.jpeg',
              height: 80,
              width: 80,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 10,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 180,
                  child: Text(
                    "Cà Phê Kem Trứng",
                    style: TextStyle(fontFamily: 'Comfortaa', fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    "25.000Đ",
                    style: TextStyle(fontFamily: 'Comfortaa', fontSize: 17),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _onPressDecrease,
                      child: Visibility(
                        visible: widget._quantity > 0,
                        child: const CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.orangeColor,
                          child: Icon(
                            Icons.remove_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget._quantity > 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          widget._quantity.toString(),
                          style: const TextStyle(fontFamily: 'Comfortaa'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _onPressIncrease,
                      child: const CircleAvatar(
                        radius: 10,
                        backgroundColor: AppColors.orangeColor,
                        child: Icon(
                          Icons.add_outlined,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
