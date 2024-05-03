import 'package:cloud_firestore/cloud_firestore.dart';
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
  var userDetail = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
          
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<DocumentSnapshot>(
                    future: userDetail,
                    builder:
                        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                          
                          return Text(
                            "Hello, ${data["name"]}",
                            style: primaryTextStyle.copyWith(
                              fontSize: 24,
                              fontWeight: semiBold
                            ),
                          );
                        }
                        return Text("");
                    },
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future: userDetail,
                    builder:
                        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                          
                          return Text(
                            "@${data["username"]}",
                            style: subtitleTextStyle.copyWith(
                              fontSize: 16
                            ),
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
                  image: NetworkImage(
                    "https://picsum.photos/200"
                  )
                )
              ),
            )
          ],
        ),
      );  
    }
    
    // Widget categories() {
    //   return Container(
    //     margin: EdgeInsets.only(
    //       top: defaultMargin
    //     ),
    //     child: SingleChildScrollView(
    //       scrollDirection: Axis.horizontal,
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: defaultMargin,
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 12,
    //               vertical: 10
    //             ),
    //             margin: EdgeInsets.only(right: 16),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               color: primaryColor
    //             ),
    //             child: Text(
    //               'All Shoes',
    //               style: primaryTextStyle.copyWith(
    //                 fontSize: 13,
    //                 fontWeight: medium
    //               ),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 12,
    //               vertical: 10
    //             ),
    //             margin: EdgeInsets.only(right: 16),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               border: Border.all(
    //                 color: subtitleColor
    //               ),
    //               color: transparentColor
    //             ),
    //             child: Text(
    //               'Running',
    //               style: primaryTextStyle.copyWith(
    //                 fontSize: 13,
    //                 fontWeight: medium,
    //                 color: subtitleColor
    //               ),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 12,
    //               vertical: 10
    //             ),
    //             margin: EdgeInsets.only(right: 16),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               border: Border.all(
    //                 color: subtitleColor
    //               ),
    //               color: transparentColor
    //             ),
    //             child: Text(
    //               'Training',
    //               style: primaryTextStyle.copyWith(
    //                 fontSize: 13,
    //                 fontWeight: medium,
    //                 color: subtitleColor
    //               ),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 12,
    //               vertical: 10
    //             ),
    //             margin: EdgeInsets.only(right: 16),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               border: Border.all(
    //                 color: subtitleColor
    //               ),
    //               color: transparentColor
    //             ),
    //             child: Text(
    //               'Basketball',
    //               style: primaryTextStyle.copyWith(
    //                 fontSize: 13,
    //                 fontWeight: medium,
    //                 color: subtitleColor
    //               ),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 12,
    //               vertical: 10
    //             ),
    //             margin: EdgeInsets.only(right: 16),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               border: Border.all(
    //                 color: subtitleColor
    //               ),
    //               color: transparentColor
    //             ),
    //             child: Text(
    //               'Hiking',
    //               style: primaryTextStyle.copyWith(
    //                 fontSize: 13,
    //                 fontWeight: medium,
    //                 color: subtitleColor
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   );
    // }

    // Widget popularProducts() {
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
    //           'Popular Products',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 22,
    //             fontWeight: semiBold
    //           ),
    //         ),
    //       ),
    //       Container(
    //         margin: EdgeInsets.only(
    //           top: 14,
    //           left: defaultMargin,
    //           right: defaultMargin,
    //         ),
    //         child: SingleChildScrollView(
    //           scrollDirection: Axis.horizontal,
    //           child: Row(
    //             children: productProvider.products.map(
    //               (product) => ProductCard(product: product)
    //             ).toList()
    //           ),
    //         ),
    //       )
    //     ],
    //   );
    // }

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
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 22,
    //             fontWeight: semiBold
    //           ),
    //         ),
    //       ),
    //       Container(
    //         margin: EdgeInsets.only(
    //           top: 14,
    //         ),
    //         child: Column(
    //           children: [
    //             ProductTile(product: productProvider.products[0]),
    //             ProductTile(product: productProvider.products[1]),
    //             ProductTile(product: productProvider.products[2]),
    //             ProductTile(product: productProvider.products[3]),
    //           ]
    //         )
    //       )
    //     ],
    //   );
    // }

    return ListView(
      children: [
        header(),
        // categories(),
        // popularProducts(),
        // newArrivals(),
      ],
    );
  }
}