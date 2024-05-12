// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_firebase/pages/admin/products/product_detail_page.dart';
import 'package:ecommerce_firebase/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
  
    Widget content() {
      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 30),
          // decoration: BoxDecoration(
          //   borderRadius: const BorderRadius.all(Radius.circular(10)),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data Customers",
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: MediaQuery.of(context).size.width + 120,
                  child: Column(
                    children: [
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(4),
                        }, 
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                              decoration: BoxDecoration(color: bgColor3),
                              children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10
                                    ),
                                    child: Text(
                                      "Name",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10
                                    ),
                                    child: Text(
                                      "Username",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10
                                    ),
                                    child: Text(
                                      "Email",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(4),
                        }, 
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: dataRows(userProvider, context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          content()
        ],
      ),
    );
  }
}

List<TableRow> dataRows(UserProvider userProvider, BuildContext context) {
  return userProvider.customers
      .map((user) => TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailPage.routeName, arguments: user);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    user.name,
                    style: primaryTextStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailPage.routeName, arguments: user);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    user.username,
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailPage.routeName, arguments: user);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    user.email,
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            // TableCell(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       GestureDetector(
            //         onTap: () {},
            //         child: Image.asset(
            //           'assets/icon_edit.png',
            //           width: 16,
            //           color: Colors.amber[600],
            //         ),
            //       ),
            //       const SizedBox(width: 8),
            //       GestureDetector(
            //         onTap: () {},
            //         child: Image.asset(
            //           'assets/icon_delete.png',
            //           width: 16,
            //           color: Colors.red[400],
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ]))
      .toList();
}