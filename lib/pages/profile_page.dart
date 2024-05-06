import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget header(user, handleLogout) {
    return AppBar(
      backgroundColor: bgColor1,
      automaticallyImplyLeading: false,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.all(defaultMargin),
          child: Row(
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: user,
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;

                    return ClipOval(
                      child: Image.network(
                        data["profile_url"],
                        width: 64,
                      ),
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<DocumentSnapshot>(
                      future: user,
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          return Text(
                            data["name"],
                            style: primaryTextStyle.copyWith(
                                fontSize: 24, fontWeight: semiBold),
                          );
                        }
                        return Text("");
                      },
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: user,
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          return Text(
                            "@${data["username"]}",
                            style: subtitleTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          );
                        }
                        return Text("");
                      },
                    ),
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
              style:
                  primaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile/edit');
              },
              child: menuItem("Edit Profile"),
            ),
            menuItem("Help"),
            SizedBox(height: 30),
            Text(
              'General',
              style:
                  primaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
            menuItem("Privacy & Policy"),
            menuItem("Terms of Service"),
            menuItem("Rate App"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var userDetail =
        FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    final FirebaseAuth _auth = FirebaseAuth.instance;

    handleLogout() async {
      await _auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    }

    return Column(
      children: [header(userDetail, handleLogout), content()],
    );
  }
}
