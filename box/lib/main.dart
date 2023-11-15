import 'package:box/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA-jb9J27ArBrzGChVuJemdOqmgZxgWiHY',
      authDomain: 'pbox-b4a17.firebaseapp.com',
      projectId: 'pbox-b4a17',
      storageBucket: 'pbox-b4a17.appspot.com',
      messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
      appId: '1:1049009016949:android:3aa88260719a2baf89283c',
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    //initialRoute: 'sign',
    debugShowCheckedModeBanner: false, home: SignUpScreen(),
    
    //home: SectionCard(sectionName: "Chọn Size", widgets: [ToppingCard(name: "Size S", price: "0đ",),ToppingCard(name: "Size M", price: "5000đ",),ToppingCard(name: "Size L", price: "10000đ",),],)
    );
    
  }
}
