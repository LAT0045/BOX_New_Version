import 'package:box/cards/notification_card.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationTab extends StatefulWidget {
  final bool isEmpty;

  const NotificationTab({super.key, required this.isEmpty});

  @override
  State<StatefulWidget> createState() {
    return _NotificationTabState();
  }
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:widget.isEmpty ? const EmptyNotification() : const Notification()
    );
  }
}

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "Thông Báo",
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ),
        ),
        Container(
          width: 330,
          height: 50,
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: AppColors.orangeColor, width: 1.5)), // Viền dưới
          ),
          child: ElevatedButton(
            onPressed: onPressedVoucher,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFAFAFA),
              foregroundColor: const Color(0xFFFAFAFA),
              elevation: 0,
              alignment: Alignment.centerLeft,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/svg/voucher.svg",
                  width: 30,
                  height: 30,
                  colorFilter: const ColorFilter.mode(
                    AppColors.orangeColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  "Thông báo ưu đãi",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Comfortaa',
                    color: AppColors.grayColor,
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),

                Transform.rotate(
                  angle: 3.14159265,
                  child: SvgPicture.asset(
                    "assets/svg/backarrow.svg",
                    width: 28,
                    height: 28,
                    colorFilter: const ColorFilter.mode(
                      AppColors.orangeColor,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        const SizedBox(
          height: 150,
        ),

        SvgPicture.asset(
          "assets/svg/note.svg",
          width: 100,
          height: 100,
          colorFilter: const ColorFilter.mode(
            AppColors.orangeColor,
            BlendMode.srcIn,
          ),
        ),     

        const SizedBox(
          height: 20,
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            "Chỗ này để thông báo về đơn hàng nhe :3",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 18,
              color: AppColors.grayColor,
              ),
          ),
        ),
      ],
    );
  }
}

class Notification extends StatelessWidget {
  const Notification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "Thông báo",
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ),
        ),

        Container(
          width: 330,
          height: 50,
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: AppColors.orangeColor, width: 1.5)), // Viền dưới
          ),
          child: ElevatedButton(
            onPressed: onPressedVoucher,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFAFAFA),
              foregroundColor: const Color(0xFFFAFAFA),
              elevation: 0,
              alignment: Alignment.centerLeft,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/svg/voucher.svg",
                  width: 30,
                  height: 30,
                  colorFilter: const ColorFilter.mode(
                    AppColors.orangeColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  "Thông báo ưu đãi",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Comfortaa',
                    color: AppColors.grayColor,
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),

                Transform.rotate(
                  angle: 3.14159265,
                  child: SvgPicture.asset(
                    "assets/svg/backarrow.svg",
                    width: 28,
                    height: 28,
                    colorFilter: const ColorFilter.mode(
                      AppColors.orangeColor,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        Expanded(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const NotificationCard();
              }),
        )
      ],
    );
  }
}
void onPressedVoucher() {}
