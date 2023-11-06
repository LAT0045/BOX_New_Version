import 'package:box/cards/topping_card.dart';
import 'package:box/screens/home_screen.dart';
import 'package:box/cards/option_card.dart';
import 'package:box/details/food_detail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    debugShowCheckedModeBanner: false, home: HomeScreen()
    //home: SectionCard(sectionName: "Chọn Size", widgets: [ToppingCard(name: "Size S", price: "0đ",),ToppingCard(name: "Size M", price: "5000đ",),ToppingCard(name: "Size L", price: "10000đ",),],)
    );
    
  }
}
