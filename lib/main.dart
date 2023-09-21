import 'package:flutter/material.dart';
import 'package:gardenia/sample.dart';
import 'package:gardenia/shared/bottomnavigation/bottom_bar.dart';
import 'package:gardenia/view/authentication_screens/log_in/log_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: ScreenNavWidget(),
      home: ScreenLogin(),
    );
  }
}
