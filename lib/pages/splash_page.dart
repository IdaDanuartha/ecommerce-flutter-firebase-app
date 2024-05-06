import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

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

    if(user?.uid != null) {
      var userDetail =
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then(
        (DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;
            if(data["role"] == "admin" || data["role"] == "staff") {
              Navigator.pushNamed(context, '/dashboard');
            } else {
              Navigator.pushNamed(context, '/home');
            }
          },
          onError: (e) => print("Error getting document: $e"),
      );
      // Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, '/sign-in');
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image_splash.png')
            )
          ),
        ),
      ),
    );
  }
}