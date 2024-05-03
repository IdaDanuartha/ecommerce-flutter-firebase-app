import 'package:ecommerce_firebase/pages/admin/dashboard_page.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/pages/home/cart_page.dart';
import 'package:ecommerce_firebase/pages/checkout_page.dart';
import 'package:ecommerce_firebase/pages/checkout_success_page.dart';
import 'package:ecommerce_firebase/pages/edit_profile_page.dart';
import 'package:ecommerce_firebase/pages/home/main_page.dart';
import 'package:ecommerce_firebase/pages/sign_in_page.dart';
import 'package:ecommerce_firebase/pages/sign_up_page.dart';
import 'package:ecommerce_firebase/pages/splash_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  // await dotenv.load(fileName: ".env");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => MainPage(),
          '/dashboard': (context) => DashboardPage(),
          '/profile/edit': (context) => EditProfile(),
          '/cart': (context) => CartPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccessPage(),
        },
      ),
    );
  }
}