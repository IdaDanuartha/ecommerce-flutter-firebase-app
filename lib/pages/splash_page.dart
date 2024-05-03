import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/sign-in');
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