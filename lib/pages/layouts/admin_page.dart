import 'package:MushMagic/pages/admin/customer_page.dart';
import 'package:MushMagic/pages/admin/dashboard_page.dart';
import 'package:MushMagic/pages/admin/order_page.dart';
import 'package:MushMagic/pages/admin/product_page.dart';
import 'package:MushMagic/pages/admin/staff_page.dart';
import 'package:MushMagic/pages/profile_page.dart';
import 'package:MushMagic/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:MushMagic/themes.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  static const routeName = '/dashboard';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _currentIndex = 0;
  final _screensAdmin = [
    const DashboardPage(),
    const ProductPage(),
    const OrderPage(),
    const StaffPage(),
    const CustomerPage(),
    const ProfilePage(),
  ];

  final _screensStaff = [
    const DashboardPage(),
    const ProductPage(),
    const OrderPage(),
    const CustomerPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    String userRole = userProvider.user!.role;

    List screens = userRole == "admin" ? _screensAdmin : _screensStaff;

    List<BottomNavigationBarItem> getNavigationAdmin = [
      BottomNavigationBarItem(
        icon: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Image.asset(
            'assets/icon_analytics.png',
            width: 21,
            color: _currentIndex == 0 ? primaryColor : const Color(0XFF808191),
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
            color: _currentIndex == 1 ? primaryColor : const Color(0XFF808191),
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
            color: _currentIndex == 2 ? primaryColor : const Color(0XFF808191),
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
            color: _currentIndex == 3 ? primaryColor : const Color(0XFF808191),
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
            color: _currentIndex == 4 ? primaryColor : const Color(0XFF808191),
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
            color: _currentIndex == 5 ? primaryColor : const Color(0XFF808191),
          ),
        ),
        label: '',
      ),
    ];

    List<BottomNavigationBarItem> getNavigationStaff = [
      BottomNavigationBarItem(
        icon: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Image.asset(
            'assets/icon_analytics.png',
            width: 21,
            color: _currentIndex == 0 ? primaryColor : const Color(0XFF808191),
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
            color: _currentIndex == 1 ? primaryColor : const Color(0XFF808191),
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
            color: _currentIndex == 2 ? primaryColor : const Color(0XFF808191),
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
            color: _currentIndex == 3 ? primaryColor : const Color(0XFF808191),
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
            color: _currentIndex == 4 ? primaryColor : const Color(0XFF808191),
          ),
        ),
        label: '',
      ),
    ];

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
            items: userRole == "admin" ? getNavigationAdmin : getNavigationStaff
          ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor1,
      bottomNavigationBar: customButtonNav(),
      body: Stack(
          children: screens
              .asMap()
              .map((i, screen) => MapEntry(
                  i,
                  Offstage(
                    offstage: _currentIndex != i,
                    child: screen,
                  )))
              .values
              .toList()),
    );
  }
}
