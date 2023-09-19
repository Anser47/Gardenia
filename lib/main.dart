import 'package:flutter/material.dart';
import 'package:gardenia/sample.dart';
import 'package:gardenia/shared/bottomnavigation/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenNavWidget(),
      // home: CartScreen(),
    );
  }
}
