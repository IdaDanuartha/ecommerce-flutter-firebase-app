// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_firebase/pages/admin/products/add_product_page.dart';
import 'package:ecommerce_firebase/pages/admin/products/product_detail_page.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
  
  Widget addButton() {
      return TextButton(
        onPressed: () {
          Navigator.pushNamed(context, AddProductPage.routeName);
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color.fromRGBO(172, 164, 232, .1),
            borderRadius: BorderRadius.circular(999)
          ),
          child: Image.asset(
            'assets/icon_add.png',
            width: 16,
            color: primaryColor,
          ),
        ),
      );
    }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Data Products",
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  addButton()
                ]
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 25,
                  child: Column(
                    children: [
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(1),
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
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(1),
                        }, 
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: productProvider.products.isNotEmpty ? dataRows(productProvider, context) : [
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        "No product found",
                                        style: primaryTextStyle.copyWith(
                                          color: Color.fromRGBO(255,255,255,.7)
                                        ),
                                      ),
                                    ),
                                ),
                              ),
                            ]
                          )
                        ]
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

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            content(),
          ],
        ),
      ),
    );
  }
}

List<TableRow> dataRows(ProductProvider productProvider, BuildContext context) {
  return productProvider.products
      .map((product) => TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailPage.routeName, arguments: product);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    product.name,
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailPage.routeName, arguments: product);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "RM ${product.price.toString()}",
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailPage.routeName, arguments: product);
                },
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