import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var userDetail =
        FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

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
                      return Text("");
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
                      return Text("");
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/200"))),
            )
          ],
        ),
      );
    }

    Widget popularProducts() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Text(
              'All Products',
              style:
                  primaryTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 14,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              // onTap: () {
                              //   Navigator.push(
                              //       context,x
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               ProductPage(product: product)));
                              // },
                              child: Container(
                                width: 300,
                                height: 272,
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: bgColor4,
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        "https://picsum.photos/1000",
                                        width: 300,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Sepatu",
                                            style: secondaryTextStyle.copyWith(
                                                fontSize: 12),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            "Nike New Era 2024 - 2025",
                                            style: primaryTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: semiBold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            "\$15.99",
                                            style: priceTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: medium),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              // onTap: () {
                              //   Navigator.push(
                              //       context,x
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               ProductPage(product: product)));
                              // },
                              child: Container(
                                width: 300,
                                height: 272,
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: bgColor4,
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        "https://picsum.photos/1000",
                                        width: 300,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Sepatu",
                                            style: secondaryTextStyle.copyWith(
                                                fontSize: 12),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            "Nike New Era 2024 - 2025",
                                            style: primaryTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: semiBold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            "\$15.99",
                                            style: priceTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: medium),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              // onTap: () {
                              //   Navigator.push(
                              //       context,x
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               ProductPage(product: product)));
                              // },
                              child: Container(
                                width: 300,
                                height: 272,
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: bgColor4,
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        "https://picsum.photos/1000",
                                        width: 300,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Sepatu",
                                            style: secondaryTextStyle.copyWith(
                                                fontSize: 12),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            "Nike New Era 2024 - 2025",
                                            style: primaryTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: semiBold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            "\$15.99",
                                            style: priceTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: medium),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )))
        ],
      );
    }

    // Widget newArrivals() {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         margin: EdgeInsets.only(
    //           top: defaultMargin,
    //           left: defaultMargin,
    //           right: defaultMargin,
    //         ),
    //         child: Text(
    //           'New Arrivals',
    //           style:
    //               primaryTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
    //         ),
    //       ),
    //       Container(
    //           margin: EdgeInsets.only(
    //             top: 14,
    //           ),
    //           child: Column(children: [
    //             GestureDetector(
    //               onTap: () {
    //                 // Navigator.push(
    //                 //     context,
    //                 //     MaterialPageRoute(
    //                 //         builder: (context) =>
    //                 //             ProductPage(product: product)));
    //               },
    //               child: Container(
    //                 margin: EdgeInsets.only(
    //                   left: defaultMargin,
    //                   right: defaultMargin,
    //                   bottom: defaultMargin,
    //                 ),
    //                 padding: EdgeInsets.all(20),
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(16),
    //                   color: bgColor4,
    //                 ),
    //                 child: Row(
    //                   children: [
    //                     ClipRRect(
    //                       borderRadius: BorderRadius.circular(10),
    //                       child: Image.network(
    //                         "https://picsum.photos/1001",
    //                         width: 120,
    //                         height: 120,
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: 12,
    //                     ),
    //                     Expanded(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             "Sepatu",
    //                             style:
    //                                 secondaryTextStyle.copyWith(fontSize: 12),
    //                           ),
    //                           SizedBox(
    //                             height: 6,
    //                           ),
    //                           Text(
    //                             "Adidas New Era 2025",
    //                             style: primaryTextStyle.copyWith(
    //                                 fontSize: 16, fontWeight: semiBold),
    //                           ),
    //                           SizedBox(
    //                             height: 6,
    //                           ),
    //                           Text(
    //                             "\$99.45",
    //                             style:
    //                                 priceTextStyle.copyWith(fontWeight: medium),
    //                           )
    //                         ],
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ]))
    //     ],
    //   );
    // }

    return ListView(
      children: [
        header(),
        popularProducts(),
        // newArrivals(),
      ],
    );
  }
}
