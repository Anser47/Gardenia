import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/firebase_options.dart';
import 'package:gardenia/provider/address/address_provider.dart';
import 'package:gardenia/provider/bottomnavbar/bottom_nav_bar_provider.dart';
import 'package:gardenia/provider/cart/cart_provider.dart';
import 'package:gardenia/provider/checkout_provider/checkout_provider.dart';
import 'package:gardenia/view/splash_screen.dart';
import 'package:provider/provider.dart';

//
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavBarBottom(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomSheetProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AlertDialogProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RazorpayProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
//