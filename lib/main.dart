import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/firebase_options.dart';
import 'package:gardenia/shared/bottomnavigation/bottom_bar.dart';
import 'package:gardenia/view/authentication_screens/log_in/log_in.dart';
import 'package:gardenia/view/authentication_screens/log_in/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ScreenSplash();
          }
          if (snapshot.hasData) {
            return ScreenNavWidget();
          }
          return const ScreenLogin();
        },
      ),
    );
  }
}
