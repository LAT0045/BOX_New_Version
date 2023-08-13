import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteFoodCard extends StatelessWidget {
  const FavoriteFoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 100,
      width: double.infinity,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFFECECEC), width: 2)),
          color: const Color(0xFFF7F7F7)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/test/ca_phe_kem_trung.jpeg',
              height: 80,
              width: 80,
              fit: BoxFit.fill,
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  "Cà phê kem trứngggggggggggggggggggggg",
                  style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: 200,
                  child: Text(
                    "Milano Coffee",
                    style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Text(
                  "25.000Đ",
                  style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
                ),
              )
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SvgPicture.asset(
                  "assets/svg/heart_icon.svg",
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
