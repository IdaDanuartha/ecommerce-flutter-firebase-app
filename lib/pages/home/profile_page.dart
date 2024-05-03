import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/models/user_model.dart';
import 'package:ecommerce_firebase/providers/auth_provider.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {      
  Widget header(UserModel user, handleLogout) {
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
                  "https://picsum.photos/200",
                  width: 64,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, ${user.name}",
                      style: primaryTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold
                      ),
                    ),
                    Text(
                      "@dandev14",
                      style: subtitleTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: handleLogout,
                child: Image.asset(
                  'assets/button_exit.png',
                  width: 20,
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
            style: secondaryTextStyle.copyWith(
              fontSize: 15
            ),
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
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin
        ),
        decoration: BoxDecoration(
          color: bgColor3
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Account',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile/edit');
              },
              child: menuItem("Edit Profile"),
            ),
            menuItem("Your Orders"),
            menuItem("Help"),
            SizedBox(height: 30),
            Text(
              'General',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold
              ),
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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    handleLogout() async {
      if(await authProvider.logout()) {
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/sign-in', 
          (route) => false
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Logout failed',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    return Column(
      children: [
        header(user, handleLogout),
        content()
      ],
    );
  }
}