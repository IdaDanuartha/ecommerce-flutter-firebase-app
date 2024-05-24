import 'package:ecommerce_firebase/pages/admin/customers/customer_detail_page.dart';
import 'package:ecommerce_firebase/pages/admin/products/add_product_page.dart';
import 'package:ecommerce_firebase/pages/admin/staff/add_staff_page.dart';
import 'package:ecommerce_firebase/pages/admin/products/product_detail_page.dart';
import 'package:ecommerce_firebase/pages/admin/products/edit_product_page.dart';
import 'package:ecommerce_firebase/pages/admin/staff/edit_staff_page.dart';
import 'package:ecommerce_firebase/pages/admin/staff/staff_detail.page.dart';
import 'package:ecommerce_firebase/pages/auth/forgot_password_page.dart';
import 'package:ecommerce_firebase/pages/auth/send_email_success_page.dart';
import 'package:ecommerce_firebase/pages/home/cart_page.dart';
import 'package:ecommerce_firebase/pages/home/order_detail_page.dart';
import 'package:ecommerce_firebase/pages/home/product_detail_page.dart';
import 'package:ecommerce_firebase/pages/home/order_page.dart';
import 'package:ecommerce_firebase/pages/layouts/admin_page.dart';
import 'package:ecommerce_firebase/providers/cart_provider.dart';
import 'package:ecommerce_firebase/providers/order_provider.dart';
import 'package:ecommerce_firebase/providers/places_provider.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:ecommerce_firebase/providers/staff_provider.dart';
import 'package:ecommerce_firebase/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerce_firebase/pages/home/checkout_page.dart';
import 'package:ecommerce_firebase/pages/home/checkout_success_page.dart';
import 'package:ecommerce_firebase/pages/edit_profile_page.dart';
import 'package:ecommerce_firebase/pages/layouts/main_page.dart';
import 'package:ecommerce_firebase/pages/auth/sign_in_page.dart';
import 'package:ecommerce_firebase/pages/auth/sign_up_page.dart';
import 'package:ecommerce_firebase/pages/splash_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

  Stripe.publishableKey = dotenv.env["STRIPE_PUBLISHABLE_KEY"]!;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // void checkConnection() async {
    //   final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    //   // ignore: unrelated_type_equality_checks
    //   if (connectivityResult == ConnectivityResult.none) {
    //     // ignore: use_build_context_synchronously
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text(
    //         'You\'re not connected to a network')
    //     ));
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text(
    //         'You\'re connected to a network')
    //     ));
    //   }
    // }

    // checkConnection();
 
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => PlacesProvider()),
        ChangeNotifierProvider(create: (context) => StaffProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          SignInPage.routeName: (context) => const SignInPage(),
          SignUpPage.routeName: (context) => SignUpPage(),
          ForgotPasswordPage.routeName: (context) => const ForgotPasswordPage(),
          SendEmailSuccessPage.routeName: (context) => const SendEmailSuccessPage(),

          AdminPage.routeName: (context) => const AdminPage(),
          AddProductPage.routeName: (context) => const AddProductPage(),
          ProductDetailPage.routeName: (context) => const ProductDetailPage(),
          EditProductPage.routeName: (context) => const EditProductPage(),

          AddStaffPage.routeName: (context) => const AddStaffPage(),
          StaffDetailPage.routeName: (context) => const StaffDetailPage(),
          EditStaffPage.routeName: (context) => const EditStaffPage(),

          CustomerDetailPage.routeName: (context) => const CustomerDetailPage(),

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