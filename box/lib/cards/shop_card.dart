import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';

class ShopCard extends StatelessWidget {
  final String imagePath;

  const ShopCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Color(0xFFECECEC), width: 2)),
            color: Colors.grey[200]),
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

                  //
                  SizedBox(
                    width: 250,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/star.svg",
                          height: 20,
                          width: 20,
                          colorFilter: const ColorFilter.mode(
                              AppColors.orangeColor, BlendMode.srcIn),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "5.0",
                            style: TextStyle(
                                fontFamily: 'Comfortaa', fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
