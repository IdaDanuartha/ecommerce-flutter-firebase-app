import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MushMagic/pages/edit_profile_page.dart';
import 'package:MushMagic/pages/auth/sign_in_page.dart';
import 'package:MushMagic/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:MushMagic/themes.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    final FirebaseAuth _auth = FirebaseAuth.instance;

    handleLogout() async {
      await _auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    }

    Widget header() {
      return AppBar(
        backgroundColor: bgColor1,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(defaultMargin),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    userProvider.user!.profileUrl != ""
                        ? userProvider.user!.profileUrl
                        : "https://firebasestorage.googleapis.com/v0/b/ecommerce-flutter-22e70.appspot.com/o/users%2Fuser.png?alt=media&token=f8257f26-5525-4216-8cac-99c9184b7467",
                    width: 64,
                    height: 64,
                    fit:BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProvider.user!.name,
                        style: primaryTextStyle.copyWith(
                            fontSize: 20, fontWeight: semiBold),
                      ),
                      Text(
                        "@${userProvider.user!.username}",
                        style: subtitleTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: handleLogout,
                  child: Image.asset(
                    'assets/button_exit.png',
                    width: 20,
                    color: primaryTextColor,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem(String text) {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: secondaryTextStyle.copyWith(fontSize: 15),
            ),
            Icon(
              Icons.chevron_right,
              color: primaryTextColor,
            )
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          decoration: BoxDecoration(color: bgColor3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Account',
                style: primaryTextStyle.copyWith(
                    fontSize: 18, fontWeight: semiBold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, EditProfile.routeName);
                },
                child: menuItem("Edit Profile"),
              ),
              menuItem("Help"),
              SizedBox(height: 30),
              Text(
                'General',
                style: primaryTextStyle.copyWith(
                    fontSize: 18, fontWeight: semiBold),
              ),
              menuItem("Privacy & Policy"),
              menuItem("Terms of Service"),
              menuItem("Rate App"),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [header(), content()],
    );
  }
}
