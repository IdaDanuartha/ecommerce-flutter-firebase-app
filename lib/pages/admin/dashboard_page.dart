import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/providers/order_provider.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:ecommerce_firebase/providers/user_provider.dart';
import 'package:ecommerce_firebase/widgets/charts/bar_chart.dart';
import 'package:ecommerce_firebase/widgets/charts/pie_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    int productCount = productProvider.products.length;
    int staffCount = userProvider.staff.length;
    int customerCount = userProvider.customers.length;
    int orderCount = orderProvider.orders.length;

    String userRole = userProvider.user!.role;

    List<double> ordersMonthly = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, ${userProvider.user!.name}",
                    style: primaryTextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold),
                  ),
                  Text(
                    "@${userProvider.user!.username}",
                    style: subtitleTextStyle.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
            ClipOval(
              child: Image.network(
                userProvider.user!.profileUrl != ""
                    ? userProvider.user!.profileUrl
                    : "https://picsum.photos/id/64/100",
                width: 54,
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> dataAdmin = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Products",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  productCount > 0 ? productCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Transactions",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  orderCount > 0 ? orderCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Staff",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  staffCount > 0 ? staffCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Customers",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  customerCount > 0 ? customerCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      )
    ];

    List<Widget> dataStaff = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Customers",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  customerCount > 0 ? customerCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Transactions",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  orderCount > 0 ? orderCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
    Widget dataCount() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        width: MediaQuery.of(context).size.width,
        child: Column(children: userRole == "admin" ? dataAdmin : dataStaff),
      );
    }

    Widget barChart() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: bgColor3, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Monthly Transactions",
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            SizedBox(
              height: 300,
              child: BarChartSample3(
                  weeklyTransactions: orderProvider.ordersMonthly.isNotEmpty
                      ? orderProvider.ordersMonthly
                      : ordersMonthly),
            ),
          ],
        ),
      );
    }

    Widget pieChart() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: bgColor3, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Monthly Transactions",
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 300,
              child: PieChartSample2(),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: ListView(
        children: [
          header(),
          dataCount(),
          barChart(),
          // pieChart()
          SizedBox(height: 30)
        ],
      ),
    );
  }
}
