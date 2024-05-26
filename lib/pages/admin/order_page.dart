// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/models/order_model.dart';
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

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    Future<void> _selectStartDate() async {
      DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: _startDateController.text != "" ? DateTime.parse(_startDateController.text) : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
      );

      if(_picked != null) {
        setState(() {
          _startDateController.text = _picked.toString().split(" ")[0];
        });
      }
    }

    Future<void> _selectEndDate() async {
      DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: _endDateController.text != "" ? DateTime.parse(_endDateController.text) : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
      );

      if(_picked != null) {
        setState(() {
          _endDateController.text = _picked.toString().split(" ")[0];
        });
      }
    }

    void clearFilter() {
      _startDateController.text = "";
      _endDateController.text = "";
    }

    void applyFilter() {
      // Parse the start and end dates from the text controllers
      String startDateString = _startDateController.text;
      String endDateString = _endDateController.text;

      try {
        DateTime startDateTime = DateTime.parse(startDateString);
        DateTime endDateTime = DateTime.parse(endDateString);

        // Convert DateTime to Timestamp
        Timestamp startDate = Timestamp.fromDate(startDateTime);
        Timestamp endDate = Timestamp.fromDate(endDateTime);

        // Filter orders
        List<OrderModel> filteredOrders = orderProvider.filterOrdersByDate(startDate, endDate);

        // Do something with the filtered orders, such as displaying them in a UI component
        print('Filtered Orders: ${filteredOrders.length}');
      } catch (e) {
        // Handle parsing errors
        print('Invalid date format');
      }
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
              Text(
                "Data Orders",
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _startDateController,
                      style: primaryTextStyle,
                      decoration: InputDecoration(
                        labelText: "Start Date",
                        labelStyle: primaryTextStyle.copyWith(
                          color: _startDateController.text != "" ? Colors.white24 : Colors.white
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today
                        ),
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: primaryColor)
                        // ),
                      ),
                      readOnly: true,
                      onTap: _selectStartDate
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _endDateController,
                      style: primaryTextStyle,
                      decoration: InputDecoration(
                        labelText: "End Date",
                        labelStyle: primaryTextStyle.copyWith(
                          color: _endDateController.text != "" ? Colors.white24 : Colors.white
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today
                        ),
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: primaryColor)
                        // ),
                      ),
                      readOnly: true,
                      onTap: _selectEndDate
                    ),
                  )
                ]
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: clearFilter,
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Clear',
                        style:
                            primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: applyFilter,
                      style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Apply',
                        style:
                            primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
                      ),
                    ),
                  ),
                ]
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
                    "RM ${(order.subTotal + order.deliveryFee - order.totalDiscount).toStringAsFixed(0)}",
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
                                ? Colors.orange[100] : order.status == 3 ? 
                                 Colors.green[100] : Colors.red[100],
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Text(
                        order.status == 1
                            ? "Preparing Order"
                            : order.status == 2
                                ? "Out for Delivery" : order.status == 3 ?
                                "Delivered" : "Cancelled",
                        style: primaryTextStyle.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: order.status == 1
                                ? Colors.amber[700]
                                : order.status == 2
                                    ? Colors.orange[700] : order.status == 3 ?
                                    Colors.green[700] : Colors.red[700]),
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
