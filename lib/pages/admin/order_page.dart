// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_firebase/pages/admin/products/add_product_page.dart';
import 'package:ecommerce_firebase/pages/admin/products/detail_product_page.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
  
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
                "Data Orders",
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
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
                                      "Price",
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
                                      "Qty",
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
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                        }, 
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: dataRows(productProvider, context),
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

List<TableRow> dataRows(ProductProvider productProvider, BuildContext context) {
  return productProvider.products
      .map((product) => TableRow(children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailProductPage.routeName, arguments: product);
              },
              child: TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16
                  ),
                  child: Text(
                    product.name,
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailProductPage.routeName, arguments: product);
              },
              child: TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "\$${product.price.toString()}",
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailProductPage.routeName, arguments: product);
              },
              child: TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    product.qty.toString(),
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