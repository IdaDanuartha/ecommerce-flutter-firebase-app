import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/helpers/my_separator.dart';
import 'package:ecommerce_firebase/helpers/send_to_gmail.dart';
import 'package:ecommerce_firebase/models/order_model.dart';
import 'package:ecommerce_firebase/providers/order_provider.dart';
import 'package:ecommerce_firebase/providers/user_provider.dart';
import 'package:ecommerce_firebase/widgets/order_item_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  static const routeName = '/home/orders/detail';

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  bool isLoading = false;

  List<DropdownMenuItem<String>> get statusItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("Preparing Order"), value: "Preparing Order"),
      const DropdownMenuItem(
          child: Text("Out for Delivery"), value: "Out for Delivery"),
      const DropdownMenuItem(child: Text("Delivered"), value: "Delivered"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OrderModel;
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    String userRole = userProvider.user!.role;

    String statusSelected = args.status == 1
        ? "Preparing Order"
        : args.status == 2
            ? "Out for Delivery"
            : "Delivered";

    void handleCancelOrder() async {
      setState(() {
        isLoading = true;
      });

      var updateOrder =
          await orderProvider.cancelOrder(args.id, {"status": 4}, context);

      String totalPrice =
          (args.subTotal + 0 - args.totalDiscount).toStringAsFixed(2);

      sendToGmail("Order Cancelled", "cancelled", args.code, totalPrice,
          userProvider, context);

      var nav = Navigator.of(context);
      nav.pop();
      nav.pop();

      if (updateOrder) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'Order cancelled successfully',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'Failed to cancel order',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = true;
      });
    }

    void handleChangeStatusOrder() async {
      setState(() {
        isLoading = true;
      });

      int getStatus = statusSelected == "Preparing Order" ? 1 : statusSelected == "Out for Delivery" ? 2 : 3;
      
      var updateOrder =
          await orderProvider.changeStatusOrder(args.id, {"status": getStatus}, context);

      if(getStatus == 3) {
        await FirebaseFirestore.instance.collection('users').doc(args.userId).get().then(
        (DocumentSnapshot doc) async {
            final data = doc.data() as Map<String, dynamic>;
            sendMessageToCustomer("Order Delivered", statusSelected, args.code, data["email"], context);
          },
          onError: (e) => print("Error getting document: $e"),
        );
      }
        
      var nav = Navigator.of(context);
      nav.pop();
      nav.pop();

      if (updateOrder) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'Order status changed successfully',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'Failed to change status order',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = true;
      });
    }

    AppBar header() {
      return AppBar(
        backgroundColor: bgColor1,
        centerTitle: true,
        title: Text(
          "Order Details",
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: primaryTextColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }

    Widget cancelOrderBtn() {
      return Container(
        margin: EdgeInsets.only(bottom: 14),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    backgroundColor: bgColor1,
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cancel Confirmation",
                              style: primaryTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 20)),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                    insetPadding: const EdgeInsets.all(10),
                    content: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Text(
                            "Confirmation Order Cancelation: Are you sure you want to cancel this order? This action cannot be reversed and the order will permanently canceled from the system",
                            style: primaryTextStyle.copyWith(
                                fontSize: 14,
                                color: Color.fromRGBO(255, 255, 255, .5)),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey[700],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    'Close',
                                    style: primaryTextStyle.copyWith(
                                        fontSize: 14, fontWeight: semiBold),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    handleCancelOrder();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[500],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    isLoading
                                        ? "Canceling order..."
                                        : "Yes, cancel it",
                                    style: primaryTextStyle.copyWith(
                                        fontSize: 14, fontWeight: semiBold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'Cancel Order',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
      );
    }

    Widget changeStatusButton() {
      return Container(
        margin: EdgeInsets.only(bottom: 14),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    backgroundColor: bgColor1,
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Change Status",
                              style: primaryTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 20)),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                    insetPadding: const EdgeInsets.all(10),
                    content: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 1, color: const Color(0xFF797979))),
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                              border: InputBorder.none
                                              // enabledBorder: OutlineInputBorder(
                                              //   borderSide:
                                              //       BorderSide(color: Colors.blue, width: 2),
                                              //   borderRadius: BorderRadius.circular(20),
                                              // ),
                                              // border: OutlineInputBorder(
                                              //   borderSide:
                                              //       BorderSide(color: Colors.blue, width: 2),
                                              //   borderRadius: BorderRadius.circular(20),
                                              // ),
                                              // filled: true,
                                              // fillColor: Colors.blueAccent,
                                              ),
                                          elevation: 0,
                                          dropdownColor: bgColor3,
                                          style: TextStyle(
                                            color: primaryTextColor,
                                          ),
                                          value: statusSelected,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              statusSelected = newValue!;
                                            });
                                          },
                                          items: statusItems))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey[700],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    'Close',
                                    style: primaryTextStyle.copyWith(
                                        fontSize: 14, fontWeight: semiBold),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    handleChangeStatusOrder();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    isLoading
                                        ? "Saving..."
                                        : "Yes, Change it",
                                    style: primaryTextStyle.copyWith(
                                        fontSize: 14, fontWeight: semiBold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'Change Status',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
      );
    }

    Widget basicInformation() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Code",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5), fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "#${args.code}",
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Order Date",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5), fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Text(
                    DateFormat.yMMMd().format(args.createdAt.toDate()),
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Time",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5), fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Text(
                    DateFormat.jms().format(args.createdAt.toDate()),
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Order Status",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5), fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: args.status == 1
                            ? Colors.amber[100]
                            : args.status == 2
                                ? Colors.orange[100]
                                : args.status == 3
                                    ? Colors.green[100]
                                    : Colors.red[100],
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      args.status == 1
                          ? "Preparing Order"
                          : args.status == 2
                              ? "Out for Delivery"
                              : args.status == 3
                                  ? "Delivered"
                                  : "Cancelled",
                      style: primaryTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: args.status == 1
                              ? Colors.amber[700]
                              : args.status == 2
                                  ? Colors.orange[700]
                                  : args.status == 3
                                      ? Colors.green[700]
                                      : Colors.red[700]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }

    Widget divider({double top = 15, double bottom = 15}) {
      return Column(
        children: [
          SizedBox(height: top),
          Divider(
            thickness: 0.5,
            color: subtitleColor,
          ),
          SizedBox(height: bottom),
        ],
      );
    }

    Widget customerInformation() {
      return Column(
        children: [
          Row(
            children: [
              Image.asset(
                "assets/icon_customer.png",
                width: 24,
                color: priceColor,
              ),
              SizedBox(width: 10),
              Text(
                "Customer Information",
                style: primaryTextStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5), fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 200,
                    child: Text(
                      args.customerName,
                      style: primaryTextStyle.copyWith(fontSize: 14),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Phone",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5), fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Text(
                    args.phone,
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }

    Widget addressInformation() {
      return Column(
        children: [
          Row(
            children: [
              Image.asset(
                "assets/icon_address.png",
                width: 24,
                color: priceColor,
              ),
              SizedBox(width: 10),
              Text(
                "Address Information",
                style: primaryTextStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Country",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5), fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 200,
                    child: Text(
                      args.address.country,
                      style: primaryTextStyle.copyWith(fontSize: 14),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Province",
                      style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5),
                        fontSize: 12,
                      )),
                  SizedBox(height: 5),
                  Text(
                    args.address.province,
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "City",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5), fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 200,
                    child: Text(
                      args.address.city,
                      style: primaryTextStyle.copyWith(fontSize: 14),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Subdistrict",
                      style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5),
                        fontSize: 12,
                      )),
                  SizedBox(height: 5),
                  Text(
                    args.address.subdistrict,
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Details",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5), fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Text(
                      args.address.details,
                      style: primaryTextStyle.copyWith(fontSize: 14),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }

    Widget productItems() {
      return Column(children: [
        Row(
          children: [
            Image.asset(
              "assets/icon_cart.png",
              width: 24,
              color: priceColor,
            ),
            SizedBox(width: 10),
            Text(
              "Items",
              style: primaryTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 20),
        ...args.items.map((item) => OrderItemCard(item: item)).toList(),
      ]);
    }

    Widget paymentInformation() {
      return Column(
        children: [
          Row(
            children: [
              Image.asset(
                "assets/icon_payment.png",
                width: 24,
                color: priceColor,
              ),
              SizedBox(width: 10),
              Text(
                "Payment Information",
                style: primaryTextStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                "\$${args.subTotal.toStringAsFixed(2)}",
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount",
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                "-\$${args.totalDiscount}",
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Fee",
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                "\$${args.deliveryFee}",
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 15),
          MySeparator(),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grand Total",
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                "\$${(args.subTotal + args.deliveryFee - args.totalDiscount).toStringAsFixed(2)}",
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
            width: double.infinity,
            color: bgColor3,
            child: Column(
              children: [
                userRole == "admin"
                    ? changeStatusButton()
                    : (args.status == 1 ? cancelOrderBtn() : const SizedBox()),
                basicInformation(),
                divider(),
                customerInformation(),
                divider(),
                addressInformation(),
                divider(),
                productItems(),
                divider(top: 10),
                paymentInformation(),
              ],
            )),
      );
    }

    return Scaffold(
      appBar: header(),
      backgroundColor: bgColor3,
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        child: content(),
      )),
    );
  }
}
