import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/pages/admin/dashboard_page.dart';
import 'package:ecommerce_firebase/pages/auth/sign_up_page.dart';
import 'package:ecommerce_firebase/pages/home/home_page.dart';
import 'package:ecommerce_firebase/pages/layouts/main_page.dart';
import 'package:ecommerce_firebase/providers/cart_provider.dart';
import 'package:ecommerce_firebase/providers/order_provider.dart';
import 'package:ecommerce_firebase/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:ecommerce_firebase/widgets/loading_button.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const routeName = '/login';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _passwordController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "admin" || documentSnapshot.get('role') == "staff") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/dashboard", 
            ModalRoute.withName('/dashboard')
          );
        }else{
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/home", 
            ModalRoute.withName('/home')
          );
        }
        // Navigator.pushNamed(context, '/home');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then(
        (DocumentSnapshot doc) async {
            final data = doc.data() as Map<String, dynamic>;
            
            await Provider.of<UserProvider>(context, listen: false).getUser(user!.uid);
            if(data["role"] == "admin" || data["role"] == "staff") {
              await Provider.of<OrderProvider>(context, listen: false).getOrders();
            } else {
              await Provider.of<CartProvider>(context, listen: false).loadItemsFromPrefs();
              await Provider.of<OrderProvider>(context, listen: false).getOrdersByUser(userId: user?.uid);
            }
          },
          onError: (e) => print("Error getting document: $e"),
        );

      route();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            duration: Duration(milliseconds: 1500),
            content: Text(
              'Login failed! Check your credentials and try again',
              textAlign: TextAlign.center,
            ),
          ),
        );
    }

    setState(() {
      isLoading = false;
    });
  }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login",
              style:
                  primaryTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Sign In to Continue',
              style: subtitleTextStyle,
            )
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: bgColor2, borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon_email.png',
                      width: 17,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _emailController,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Your Email Address',
                            hintStyle: subtitleTextStyle),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: bgColor2, borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon_password.png',
                      width: 17,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        style: primaryTextStyle,
                        obscureText: true,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Your Password',
                            hintStyle: subtitleTextStyle),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget signInButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultMargin),
        child: TextButton(
          onPressed: () async {
            signIn(_emailController.text, _passwordController.text);
          },
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            'Sign In',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: EdgeInsets.only(bottom: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: subtitleTextStyle.copyWith(fontSize: 12),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SignUpPage.routeName);
              },
              child: Text(
                "Sign Up",
                style: purpleTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: bgColor1,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                emailInput(),
                passwordInput(),
                isLoading ? const LoadingButton(text: "Authenticating...") : signInButton(),
                Spacer(),
                footer()
              ],
            ),
          ),
        ));
  }
}
