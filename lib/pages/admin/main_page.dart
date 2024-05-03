import 'package:ecommerce_firebase/pages/admin/dashboard_page.dart';
import 'package:ecommerce_firebase/pages/home/cart_page.dart';
import 'package:ecommerce_firebase/pages/profile_page.dart';
import 'package:ecommerce_firebase/pages/home/order_page.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final _screens = [
    DashboardPage(),
    // CartPage(),
    // WishlistPage(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Widget cartButton() {
    //   return FloatingActionButton(
    //     onPressed: () {
    //       Navigator.pushNamed(context, "/cart");
    //     },
    //     backgroundColor: secondaryColor,
    //     child: Image.asset(
    //       'assets/icon_cart.png',
    //       width: 20,
    //     ),
    //   );
    // }

    Widget customButtonNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
            backgroundColor: bgColor4,
            elevation: 0,
            currentIndex: _currentIndex,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/icon_home.png',
                    width: 21,
                    color:
                        _currentIndex == 0 ? primaryColor : Color(0XFF808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/icon_product.png',
                    width: 30,
                    color:
                        _currentIndex == 1 ? primaryColor : Color(0XFF808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/icon_order.png',
                    width: 25,
                    color:
                        _currentIndex == 2 ? primaryColor : Color(0XFF808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/icon_profile.png',
                    width: 18,
                    color:
                        _currentIndex == 3 ? primaryColor : Color(0XFF808191),
                  ),
                ),
                label: '',
              ),
            ]),
      );
    }

    return Scaffold(
      backgroundColor: _currentIndex == 0 ? bgColor1 : bgColor3,
      // floatingActionButton: cartButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customButtonNav(),
      body: Stack(
        children: _screens
              .asMap()
              .map((i, screen) => MapEntry(
                i,
                Offstage(
                  offstage: _currentIndex != i,
                  child: screen,
                )))
              .values
              .toList()
      ),
    );
  }
}
