import 'package:box/cards/notification_card.dart';
import 'package:box/class/my_notification.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotificationTabState();
  }
}

class _NotificationTabState extends State<NotificationTab> {
  List<MyNotification> notifications = [];

  void clearNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear the stored notifications in local storage
    await prefs.remove('notifications');

    // Clear the notifications list in the state
    setState(() {
      notifications.clear();
    });
  }

  void loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Retrieve stored JSON strings
      List<String>? jsonNotifications =
          prefs.getStringList('notifications') ?? [];

      // Convert JSON strings to Notification instances
      notifications = jsonNotifications
          .map((json) => MyNotification.fromJson(json))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadNotifications();
    //clearNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: notifications.isEmpty
            ? const EmptyNotification()
            : Column(
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
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          return NotificationCard(
                            notification: notifications[index],
                          );
                        }),
                  )
                ],
              ));
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

void onPressedVoucher() {}
