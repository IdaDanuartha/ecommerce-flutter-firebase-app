import 'package:ecommerce_firebase/pages/admin/dashboard_page.dart';
import 'package:ecommerce_firebase/pages/admin/product_page.dart';
import 'package:ecommerce_firebase/pages/home/cart_page.dart';
import 'package:ecommerce_firebase/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  static const routeName = '/dashboard';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _currentIndex = 0;
  final _screens = [
    const DashboardPage(),
    ProductPage(),
    CartPage(),
    CartPage(),
    const ProfilePage(),
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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
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
                  margin: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/icon_analytics.png',
                    width: 21,
                    color:
                        _currentIndex == 0 ? primaryColor : const Color(0XFF808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/icon_product.png',
                    width: 28,
                    color:
                        _currentIndex == 1 ? primaryColor : const Color(0XFF808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/icon_order.png',
                    width: 23,
                    color:
                        _currentIndex == 2 ? primaryColor : const Color(0XFF808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/icon_users.png',
                    width: 23,
                    color:
                        _currentIndex == 3 ? primaryColor : const Color(0XFF808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/icon_settings.png',
                    width: 20,
                    color:
                        _currentIndex == 4 ? primaryColor : const Color(0XFF808191),
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
