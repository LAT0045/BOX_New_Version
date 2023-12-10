import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:box/details/order_history_detail.dart';
import 'package:box/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA-jb9J27ArBrzGChVuJemdOqmgZxgWiHY',
      authDomain: 'pbox-b4a17.firebaseapp.com',
      projectId: 'pbox-b4a17',
      storageBucket: 'pbox-b4a17.appspot.com',
      messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
      appId: '1:1049009016949:android:3aa88260719a2baf89283c',
    ),
  );

  //'resource://drawable/box_app_logo'
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'main_channel',
        channelName: 'main_channel',
        channelDescription: 'main_channel notifications',
        enableLights: true,
        importance: NotificationImportance.Max,
      )
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        locale: const Locale('vi'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        home: LoginScreen());
  }
}
