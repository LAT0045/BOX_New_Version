import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LastestCard extends StatelessWidget {
  final String imagePath;
  final String shopName;
  final String iconType;
  final String otherInfo;

  const LastestCard(
      {super.key,
      required this.shopName,
      required this.imagePath,
      required this.iconType,
      required this.otherInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Color(0xFFECECEC), width: 2)),
            color: const Color(0xFFF7F7F7)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    shopName,
                    style:
                        const TextStyle(fontFamily: 'Comfortaa', fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      iconType == "voucher"
                          ? SvgPicture.asset(
                              "assets/svg/voucher.svg",
                              height: 25,
                              width: 25,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.orangeColor, BlendMode.srcIn),
                            )
                          : SvgPicture.asset(
                              "assets/svg/location_icon.svg",
                              height: 20,
                              width: 20,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.orangeColor, BlendMode.srcIn),
                            ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        otherInfo,
                        style: const TextStyle(
                            fontFamily: 'Comfortaa', fontSize: 15),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
