import 'package:cloud_firestore/cloud_firestore.dart';
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
    UserProvider userProvider= Provider.of<UserProvider>(context);

    int productCount = productProvider.products.length;
    int staffCount = userProvider.staff.length;
    int customerCount = userProvider.customers.length;

    User? user = FirebaseAuth.instance.currentUser;
    var userDetail =
        FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    List<double> weeklyTransactions = [20, 30, 10, 5, 50, 100, 35];

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
                  FutureBuilder<DocumentSnapshot>(
                    future: userDetail,
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return Text(
                          "Hello, ${data["name"]}",
                          style: primaryTextStyle.copyWith(
                              fontSize: 24, fontWeight: semiBold),
                        );
                      }
                      return const Text("");
                    },
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future: userDetail,
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return Text(
                          "@${data["username"]}",
                          style: subtitleTextStyle.copyWith(fontSize: 16),
                        );
                      }
                      return const Text("");
                    },
                  ),
                ],
              ),
            ),
            FutureBuilder<DocumentSnapshot>(
              future: userDetail,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(data["profile_url"]))),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      );
    }

    Widget dataCount() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
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
                            fontSize: 12,
                            color: Color.fromRGBO(255, 255, 255, .5)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        productCount.toString(),
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
                            fontSize: 12,
                            color: Color.fromRGBO(255, 255, 255, .5)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "-",
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
                            fontSize: 12,
                            color: Color.fromRGBO(255, 255, 255, .5)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        staffCount.toString(),
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
                            fontSize: 12,
                            color: Color.fromRGBO(255, 255, 255, .5)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        customerCount.toString(),
                        style: primaryTextStyle.copyWith(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
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
              "Weekly Transactions",
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            SizedBox(
              height: 300,
              child: BarChartSample3(weeklyTransactions: weeklyTransactions),
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
              "Weekly Transactions",
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
