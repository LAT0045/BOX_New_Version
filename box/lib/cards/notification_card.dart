import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: double.infinity,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFFECECEC), width: 2)),
          color: const Color(0xFFF7F7F7)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/test/ca_phe_kem_trung.jpeg',
                height: 70,
                width: 70,
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
                    "Tiêu đề thông báo",
                    style: TextStyle(fontFamily: 'Comfortaa', fontSize: 16, color: Color(0xFF000000), fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    width: 230,
                    child: Text(
                      "Tình yêu chỉ là hạt cát, vì đồ ăn đã lấn át tình yêu. Tình yêu chỉ là hạt cát, vì đồ ăn đã lấn át tình yêu.Tình yêu chỉ là hạt cát, vì đồ ăn đã lấn át tình yêu. ",
                      style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15, color: Color(0xFF000000)),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    "12:00",
                    style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15, color: AppColors.darkGrayColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
