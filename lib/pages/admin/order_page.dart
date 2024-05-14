// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_firebase/pages/admin/products/product_detail_page.dart';
import 'package:ecommerce_firebase/pages/home/order_detail_page.dart';
import 'package:ecommerce_firebase/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:intl/intl.dart';
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
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

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
                  width: MediaQuery.of(context).size.width + 280,
                  child: Column(
                    children: [
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(5),
                          1: FlexColumnWidth(7),
                          2: FlexColumnWidth(7),
                          3: FlexColumnWidth(5),
                          4: FlexColumnWidth(6),
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
                                        horizontal: 16, vertical: 10),
                                    child: Text(
                                      "Order Date",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    child: Text(
                                      "Order Code",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    child: Text(
                                      "Customer Name",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    child: Text(
                                      "Grand Total",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    child: Text(
                                      "Status",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(5),
                          1: FlexColumnWidth(7),
                          2: FlexColumnWidth(7),
                          3: FlexColumnWidth(5),
                          4: FlexColumnWidth(6),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: orderProvider.orders.isNotEmpty ? dataRows(orderProvider, context) : [
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        "No order found",
                                        style: primaryTextStyle.copyWith(
                                          color: Color.fromRGBO(255,255,255,.7)
                                        ),
                                      ),
                                    ),
                                ),
                              ),
                            ]
                          )
                        ],
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
        children: [content()],
      ),
    );
  }
}

List<TableRow> dataRows(OrderProvider orderProvider, BuildContext context) {
  return orderProvider.orders
      .map((order) => TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailPage.routeName,
                      arguments: order);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    DateFormat("dd-MM-yyyy").format(order.createdAt.toDate()),
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailPage.routeName,
                      arguments: order);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    order.code,
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailPage.routeName,
                      arguments: order);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    order.customerName,
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
                  Navigator.pushNamed(context, OrderDetailPage.routeName,
                      arguments: order);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "\$${(order.subTotal + order.deliveryFee - order.totalDiscount).toStringAsFixed(2)}",
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailPage.routeName,
                      arguments: order);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: order.status == 1
                            ? Colors.amber[100]
                            : order.status == 2
                                ? Colors.orange[100]
                                : Colors.green[100],
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Text(
                        order.status == 1
                            ? "Preparing Order"
                            : order.status == 2
                                ? "Out for Delivery"
                                : "Delivered",
                        style: primaryTextStyle.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: order.status == 1
                                ? Colors.amber[700]
                                : order.status == 2
                                    ? Colors.orange[700]
                                    : Colors.green[700]),
                      ),
                    ),
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
