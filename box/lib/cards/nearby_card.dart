import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NearbyCard extends StatelessWidget {
  final String imagePath;
  final bool hasVoucher;

  const NearbyCard(
      {super.key, required this.imagePath, required this.hasVoucher});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Color(0xFFECECEC), width: 2)),
            color: const Color(0xFFF7F7F7)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 250,
                    child: Text(
                      "Milano Coffee",
                      style: TextStyle(fontFamily: 'Comfortaa', fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                    child: SizedBox(
                      width: 250,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/location_icon.svg",
                            height: 20,
                            width: 20,
                            colorFilter: const ColorFilter.mode(
                                AppColors.orangeColor, BlendMode.srcIn),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "100m",
                              style: TextStyle(
                                  fontFamily: 'Comfortaa', fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: hasVoucher,
                      child: SizedBox(
                        width: 250,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/voucher.svg",
                              height: 25,
                              width: 25,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Mã giảm 20%",
                                style: TextStyle(
                                    fontFamily: 'Comfortaa', fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
