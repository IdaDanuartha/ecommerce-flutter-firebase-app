import 'package:ecommerce_firebase/pages/auth/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';

class SendEmailSuccessPage extends StatefulWidget {
  const SendEmailSuccessPage({super.key});

  static const routeName = '/forgot-password/success';

  @override
  State<SendEmailSuccessPage> createState() => _SendEmailSuccessPageState();
}

class _SendEmailSuccessPageState extends State<SendEmailSuccessPage> {
  @override
  Widget build(BuildContext context) {

    Widget header() {
      return Container(
        child: Column(
          children: [
            Image.asset(
              "assets/icon_email_send.png",
              width: 200,
              color: primaryColor,
            ),
            SizedBox(height: 50),
            Text(
              "Email sent successfully",
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Check your email and click the reset",
              style: primaryTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            Text(
              "password link provided",
              style: primaryTextStyle.copyWith(
                fontSize: 14,
              ),
            )
          ],
        ),
      );
    }

    Widget backToLoginButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultMargin),
        child: TextButton(
          onPressed: () async {
            Navigator.pushNamedAndRemoveUntil(context, SignInPage.routeName, (route) => false);
          },
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            'Done',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                header(),
                backToLoginButton()
              ],
            ),
          ),
        ));
  }
}
