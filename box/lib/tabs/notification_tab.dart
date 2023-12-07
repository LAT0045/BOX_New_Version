import 'package:box/cards/notification_card.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        child:
            widget.isEmpty ? const EmptyNotification() : const Notification());
  }
}

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            AppLocalizations.of(context)!.notification,
            style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ),
        ),

        //
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/note.svg",
              width: 100,
              height: 100,
              colorFilter: const ColorFilter.mode(
                AppColors.orangeColor,
                BlendMode.srcIn,
              ),
            ),

            //
            const SizedBox(
              height: 20,
            ),

            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                AppLocalizations.of(context)!.orderNotification,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 18,
                  color: AppColors.grayColor,
                ),
              ),
            ),
          ],
        ))
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            AppLocalizations.of(context)!.notification,
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ),
        ),

        //
        Expanded(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return NotificationCard();
              }),
        )
      ],
    );
  }
}

void onPressedVoucher() {}
