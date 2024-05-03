import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/helpers/get_download_url.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:ecommerce_firebase/widgets/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    var userDetail =
        FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    ProductProvider productProvider = Provider.of<ProductProvider>(context);

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
                        image: DecorationImage(image: NetworkImage("https://picsum.photos/200"))
                      )
                  );
                }
                return Container();
              },
            ),
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
                    children: productProvider.products
                        .map((product) => ProductCard(product: product))
                        .toList(),
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
