import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/widgets/charts/bar_chart.dart';
import 'package:ecommerce_firebase/widgets/charts/pie_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
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
            Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/200"))),
            )
          ],
        ),
      );
    }

    return ListView(
      children: [
        header(),
        Container(
          margin: EdgeInsets.only(top: 50, left: defaultMargin, right: defaultMargin),
          child: const SizedBox(
            height: 300,
            // child: MyBarGraph(
            //   weeklyTransactions: weeklyTransactions,
            // ),
            child: BarChartSample3(),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: defaultMargin),
          child: const SizedBox(
            height: 300,
            child: PieChartSample2(),
          ),
        )
      ],
    );
  }
}
