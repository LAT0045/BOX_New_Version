import 'package:box/cards/voucher_detail_card.dart';
import 'package:box/class/voucher.dart';
import 'package:box/utils/colors.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';


class VoucherCard extends StatefulWidget {
  final Voucher voucher;

  const VoucherCard({super.key, required this.voucher});
  @override
  State<StatefulWidget> createState() {
    return _VoucherCardState();
  }
}

class _VoucherCardState extends State<VoucherCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          // Shop Image
          Container(
            decoration: DottedDecoration(
                shape: Shape.line,
                linePosition: LinePosition.right,
                color: AppColors.grayColor),
            width: 100,
            height: 80,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/test/milano_coffee.jpg'),
                ),
              ],
            ),
          ),

          // Information
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: 190,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Voucher info
                  Text(
                    widget.voucher.voucherName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: 'Comfortaa', fontSize: 16),
                  ),

                  // Condition
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Đơn tối thiểu " + "${NumberFormat.decimalPattern().format(widget.voucher.orderCondition).replaceAll(',', '.')}Đ",
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                      ),
                    ),
                  ),

                  // Expiration date
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/clock.svg",
                        width: 10,
                        height: 10,
                        colorFilter:
                            const ColorFilter.mode(Colors.red, BlendMode.srcIn,),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Hết hạn: " + widget.voucher.endDate,
                        style: TextStyle(
                            fontFamily: 'Comfortaa', color: Colors.red, fontSize: 14),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          // Save button
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.orangeColor),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Text(
                AppLocalizations.of(context)!.save,
                style: const TextStyle(
                    fontFamily: 'Comfortaa', color: AppColors.orangeColor, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
