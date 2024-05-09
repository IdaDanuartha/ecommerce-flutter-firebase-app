import 'package:ecommerce_firebase/pages/admin/products/add_product_page.dart';
import 'package:ecommerce_firebase/pages/admin/products/add_staff_page.dart';
import 'package:ecommerce_firebase/pages/admin/products/detail_product_page.dart';
import 'package:ecommerce_firebase/pages/admin/products/edit_product_page.dart';
import 'package:ecommerce_firebase/pages/home/cart_page.dart';
import 'package:ecommerce_firebase/pages/home/order_detail_page.dart';
import 'package:ecommerce_firebase/pages/home/product_detail_page.dart';
import 'package:ecommerce_firebase/pages/home/order_page.dart';
import 'package:ecommerce_firebase/pages/layouts/admin_page.dart';
import 'package:ecommerce_firebase/providers/cart_provider.dart';
import 'package:ecommerce_firebase/providers/order_provider.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:ecommerce_firebase/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerce_firebase/pages/checkout_page.dart';
import 'package:ecommerce_firebase/pages/checkout_success_page.dart';
import 'package:ecommerce_firebase/pages/edit_profile_page.dart';
import 'package:ecommerce_firebase/pages/layouts/main_page.dart';
import 'package:ecommerce_firebase/pages/sign_in_page.dart';
import 'package:ecommerce_firebase/pages/sign_up_page.dart';
import 'package:ecommerce_firebase/pages/splash_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

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
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          SignInPage.routeName: (context) => const SignInPage(),
          SignUpPage.routeName: (context) => SignUpPage(),

          AdminPage.routeName: (context) => const AdminPage(),
          AddProductPage.routeName: (context) => const AddProductPage(),
          DetailProductPage.routeName: (context) => const DetailProductPage(),
          EditProductPage.routeName: (context) => const EditProductPage(),

          AddStaffPage.routeName: (context) => const AddStaffPage(),

          MainPage.routeName: (context) => const MainPage(),
          ProductDetailHomePage.routeName: (context) => const ProductDetailHomePage(),

          EditProfile.routeName: (context) => const EditProfile(),

          CartPage.routeName: (context) => const CartPage(),
          OrderPage.routeName: (context) => const OrderPage(),
          OrderDetailPage.routeName: (context) => const OrderDetailPage(),
          CheckoutPage.routeName: (context) => const CheckoutPage(),
          CheckoutSuccessPage.routeName: (context) => const CheckoutSuccessPage(),
        },
      ),
    );
  }
}