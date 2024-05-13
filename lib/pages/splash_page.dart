import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/pages/layouts/admin_page.dart';
import 'package:ecommerce_firebase/pages/layouts/main_page.dart';
import 'package:ecommerce_firebase/pages/auth/sign_in_page.dart';
import 'package:ecommerce_firebase/providers/cart_provider.dart';
import 'package:ecommerce_firebase/providers/order_provider.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:ecommerce_firebase/providers/staff_provider.dart';
import 'package:ecommerce_firebase/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    await Provider.of<StaffProvider>(context, listen: false).getStaff();
    await Provider.of<UserProvider>(context, listen: false).getCustomers();
    await Provider.of<UserProvider>(context, listen: false).getAdmins();

    if(user?.uid != null) {
      await Provider.of<UserProvider>(context, listen: false).getUser(user!.uid);
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then(
        (DocumentSnapshot doc) async {
            final data = doc.data() as Map<String, dynamic>;
            if(data["role"] == "admin" || data["role"] == "staff") {
              Navigator.pushNamed(context, AdminPage.routeName);
              await Provider.of<OrderProvider>(context, listen: false).getOrders();
              await Provider.of<OrderProvider>(context, listen: false).getOrdersMonthly();
            } else {
              Navigator.pushNamed(context, MainPage.routeName);
              await Provider.of<CartProvider>(context, listen: false).loadItemsFromPrefs();
              await Provider.of<OrderProvider>(context, listen: false).getOrdersByUser(userId: user?.uid);
            }
          },
          onError: (e) => print("Error getting document: $e"),
      );
      // Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, SignInPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image_splash.png')
            )
          ),
        ),
      ),
    );
  }
}