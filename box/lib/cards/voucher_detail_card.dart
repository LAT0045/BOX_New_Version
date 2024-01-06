import 'package:box/class/voucher.dart';
import 'package:box/utils/colors.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class VoucherDetailCard extends StatefulWidget {
  final Voucher voucher;
  final Function(Voucher) onSelected;

  const VoucherDetailCard({
    Key? key,
    required this.voucher,
    required this.onSelected,
  }) : super(key: key);

  State<StatefulWidget> createState() {
    return _VoucherDetailCardState();
  }
}

class _VoucherDetailCardState extends State<VoucherDetailCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.voucher.toggleSelection();
          widget.onSelected(widget.voucher);
        });
      },
      child: Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: widget.voucher.isShipping
                  ? LinearGradient(
                      begin: Alignment(0.99, -0.16),
                      end: Alignment(-0.99, 0.16),
                      colors: [Color(0xFF9BE899), Color(0xFF2DA67B)],
                    )
                  : LinearGradient(
                      begin: Alignment(0.99, -0.16),
                      end: Alignment(-0.99, 0.16),
                      colors: [Color(0xFFEEA64B), Color(0xFFFA6400)],
                    ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Container(
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25, bottom: 10, left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            widget.voucher.isShipping
                                ? "assets/svg/ship.svg"
                                : "assets/svg/discount.svg",
                            width: 25,
                            height: 25,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: Text(
                              widget.voucher.isShipping
                                  ? "Phí giao hàng"
                                  : "Giảm giá",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: widget.voucher.isShipping
                                    ? Color(0xFF2DA67B)
                                    : AppColors.orangeColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.voucher.voucherName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Đơn tối thiểu " +
                              "${NumberFormat.decimalPattern().format(widget.voucher.orderCondition).replaceAll(',', '.')}Đ",
                          style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/clock.svg",
                              width: 15,
                              height: 15,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "HSD: " + widget.voucher.endDate,
                              style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      
                      color: Colors.white, 
                    ),
                    child: widget.voucher.isSelected
                        ? Icon(
                            Icons.check,
                            size: 20.0,
                            color:widget.voucher.isSelected
                            ? AppColors.mediumOrangeColor 
                            : Colors.white, 
                          )
                        : null,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
