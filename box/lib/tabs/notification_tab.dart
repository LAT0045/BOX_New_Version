import 'package:box/cards/notification_card.dart';
import 'package:box/class/my_notification.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationTab extends StatefulWidget {
  final UserCredential userCredential;
  const NotificationTab({super.key, required this.userCredential});

  @override
  State<StatefulWidget> createState() {
    return _NotificationTabState();
  }
}

class _NotificationTabState extends State<NotificationTab> {
  List<MyNotification> _notifications = [];
  bool _isDoneGettingInfo = false;

  Future<void> loadNotifications() async {
    final databaseReference = FirebaseDatabase.instance;
    String? userId = widget.userCredential.user?.uid.toString();

    if (userId != null) {
      final snapShot =
          await databaseReference.ref("Notifications").child(userId).get();

      // Get notifications
      setState(() {
        if (snapShot.exists) {
          final notificationMap = snapShot.value as Map;
          notificationMap.forEach((key, value) {
            _notifications.add(MyNotification.fromJson(
                Map<String, dynamic>.from(value as Map)));
          });

          // Sort list based on time
          _notifications.sort((a, b) => b.time.compareTo(a.time));
        }

        _isDoneGettingInfo = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadNotifications();
    //clearNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return !_isDoneGettingInfo
        ? SafeArea(
            child: Center(
            child: CircularProgressIndicator(),
          ))
        : SafeArea(
            child: _notifications.isEmpty
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
                            itemCount: _notifications.length,
                            itemBuilder: (context, index) {
                              return NotificationCard(
                                notification: _notifications[index],
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
