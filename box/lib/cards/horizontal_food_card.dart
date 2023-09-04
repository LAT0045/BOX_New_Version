import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';

class HorizontalFoodCard extends StatefulWidget {
  const HorizontalFoodCard({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HorizontalFoodCardState();
  }
}

class _HorizontalFoodCardState extends State<HorizontalFoodCard> {
  int _quantity = 0;

  void _onPressIncrease() {
    setState(() {
      _quantity++;
    });
  }

  void _onPressDecrease() {
    setState(() {
      _quantity--;
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
            // Food Image
            Image.asset(
              'assets/test/ca_phe_kem_trung.jpeg',
              height: 80,
              width: 80,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 10,
            ),

            // Food Information
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 180,
                    child: Text(
                      "Cà Phê Kem Trứng",
                      style: TextStyle(fontFamily: 'Comfortaa', fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Price
                      const Text(
                        "25.000Đ",
                        style: TextStyle(fontFamily: 'Comfortaa', fontSize: 17),
                      ),

                      Row(
                        children: [
                          //Decrease button
                          Visibility(
                            visible: _quantity > 0,
                            child: GestureDetector(
                              onTap: _onPressDecrease,
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

                          // Quantity
                          Visibility(
                            visible: _quantity > 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                _quantity.toString(),
                                style: const TextStyle(fontFamily: 'Comfortaa'),
                              ),
                            ),
                          ),

                          // Increase button
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
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
