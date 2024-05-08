import 'package:ecommerce_firebase/pages/admin/products/add_product_page.dart';
import 'package:ecommerce_firebase/pages/admin/products/detail_product_page.dart';
import 'package:ecommerce_firebase/pages/admin/products/edit_product_page.dart';
import 'package:ecommerce_firebase/pages/layouts/admin_page.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/pages/home/cart_page.dart';
import 'package:ecommerce_firebase/pages/checkout_page.dart';
import 'package:ecommerce_firebase/pages/checkout_success_page.dart';
import 'package:ecommerce_firebase/pages/edit_profile_page.dart';
import 'package:ecommerce_firebase/pages/layouts/main_page.dart';
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
          '/': (context) => const SplashPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/dashboard': (context) => const AdminPage(),
          AddProductPage.routeName: (context) => const AddProductPage(),
          DetailProductPage.routeName: (context) => const DetailProductPage(),
          EditProductPage.routeName: (context) => const EditProductPage(),
          '/home': (context) => const MainPage(),
          EditProfile.routeName: (context) => const EditProfile(),
          '/carts': (context) => CartPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccessPage(),
        },
      ),
    );
  }
}