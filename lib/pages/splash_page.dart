import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      if(user?.uid != null) {
        var userDetail =
        FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then(
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
      } else {
        Navigator.pushNamed(context, '/sign-in');
      }
    });
    
    super.initState();
  }

  // getInit() {
  //   Timer(const Duration(seconds: 3), () {
  //     Navigator.pushNamed(context, '/sign-in');
  //   });
  //   // await Provider.of<ProductProvider>(context, listen: false).getProducts();
  // }

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