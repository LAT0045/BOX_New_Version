import 'package:flutter/material.dart';

class DeliveryFoodCard extends StatelessWidget {
  const DeliveryFoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: Row(
          children: [
            Image.asset(
              'assets/test/ca_phe_kem_trung.jpeg',
              height: 80,
              width: 80,
              fit: BoxFit.fill,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      "Cà Phê Kem Trứng",
                      style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 200,
                      child: Text(
                        "29.000Đ",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            ),
            const Expanded(
                child: SizedBox(
              height: 80,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "x2",
                    style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
