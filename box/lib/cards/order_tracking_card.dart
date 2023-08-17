import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderTrackingCard extends StatelessWidget {
  const OrderTrackingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 120,
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
              height: 100,
              width: 100,
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
                  "Milano Coffeeeeeeeeeeeeeeeeeeeeeee",
                  style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15, color: Color(0xFF000000)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: 200,
                  child: Text(
                    "Địa chỉiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii",
                    style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15, color: Color(0xFF000000)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Text(
                  "Đang giao",
                  style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15, color: AppColors.blueColor),
                ),
              ),
              SizedBox(
                width: 200,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Text(
                      "Xem chi tiết",
                      style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15, color: AppColors.mediumOrangeColor),
                    ),
                  ),
                ),     
              ),

              
            ],
          ),
        ],
      ),
    );
  }
}
