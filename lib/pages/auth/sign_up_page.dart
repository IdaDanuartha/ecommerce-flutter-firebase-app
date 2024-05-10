import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/pages/auth/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:ecommerce_firebase/widgets/loading_button.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  static const routeName = '/register';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = TextEditingController(text: '');
  TextEditingController _usernameController = TextEditingController(text: '');
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _passwordController = TextEditingController(text: '');

  bool isLoading = false;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    postDetailsToFirestore() async {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = _auth.currentUser;
      CollectionReference ref = firebaseFirestore.collection('users');
      ref.doc(user!.uid).set({'name': _nameController.text, 'username': _usernameController.text, 'email': _emailController.text, 'role': "customer", "profile_url": ""});
      Navigator.pushNamed(context, SignInPage.routeName);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            duration: Duration(milliseconds: 2500),
            content: Text(
              'Account created successfully',
              textAlign: TextAlign.center,
            ),
          ),
        );
    }
    
    void signUp(String email, String password) async {
      await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore()})
        .catchError((e) {
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: alertColor,
                duration: Duration(milliseconds: 1500),
                content: Text(
                  'Failed to create account',
                  textAlign: TextAlign.center,
                ),
              ),
            );
        });
    }
    
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign Up",
              style:
                  primaryTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Register and Happy Shopping',
              style: subtitleTextStyle,
            )
          ],
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
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
                      'assets/icon_name.png',
                      width: 17,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Your Full Name',
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

    Widget usernameInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
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
                      'assets/icon_name.png',
                      width: 17,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _usernameController,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Your Username',
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

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
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
                // final message = await AuthService().registration(
                //   email: _emailController.text,
                //   password: _passwordController.text,
                // );
                // if (message!.contains('Success')) {
                //   Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => const HomePage())
                //   );
                // }
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     backgroundColor: alertColor,
                //     duration: Duration(milliseconds: 1000),
                //     content: Text(
                //       'Failed to create account',
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // );
                signUp(_emailController.text, _passwordController.text);
              },
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            'Create Account',
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
              "Already have an account?",
              style: subtitleTextStyle.copyWith(fontSize: 12),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SignInPage.routeName);
              },
              child: Text(
                "Sign In",
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
                nameInput(),
                usernameInput(),
                emailInput(),
                passwordInput(),
                isLoading ? LoadingButton() : signInButton(),
                Spacer(),
                footer()
              ],
            ),
          ),
        ));
  }
}
