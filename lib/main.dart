import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/view_model/firebase_options.dart';
import 'package:gardenia/provider/address/address_provider.dart';
import 'package:gardenia/provider/bottomnavbar/bottom_nav_bar_provider.dart';
import 'package:gardenia/provider/cart/cart_provider.dart';
import 'package:gardenia/provider/checkout_provider/checkout_provider.dart';
import 'package:gardenia/provider/indoor_outdoor/indoor_outdoor_provider.dart';
import 'package:gardenia/provider/search/search_provider.dart';
import 'package:gardenia/provider/wishlist/wishlist_provider.dart';
import 'package:gardenia/provider/profile/about_us/about_us.dart';
import 'package:gardenia/provider/profile/privacy_policy/Privacy_policy.dart';
import 'package:gardenia/provider/profile/terms_conditions/terms_conditions.dart';
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
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RazorpayProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductPayment(),
        ),
        ChangeNotifierProvider(
          create: (context) => AboutUsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TermsandConditonsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PrivacyPolicyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
