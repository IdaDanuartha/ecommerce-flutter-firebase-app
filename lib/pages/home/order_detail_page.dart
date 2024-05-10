import 'package:ecommerce_firebase/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:intl/intl.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  static const routeName = '/home/orders/detail';

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OrderModel;

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
                        color: Color.fromRGBO(255, 255, 255, .5)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "#${args.code}",
                    style: primaryTextStyle.copyWith(fontSize: 16),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Date",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    DateFormat.yMMMd().format(args.createdAt.toDate()),
                    style: primaryTextStyle.copyWith(fontSize: 16),
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
                        color: Color.fromRGBO(255, 255, 255, .5)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    DateFormat.jms().format(args.createdAt.toDate()),
                    style: primaryTextStyle.copyWith(fontSize: 16),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Status",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5)),
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
                                : Colors.green[100],
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      args.status == 1
                          ? "Preparing Order"
                          : args.status == 2
                              ? "Out for Delivery"
                              : "Delivered",
                      style: primaryTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: args.status == 1
                              ? Colors.amber[700]
                              : args.status == 2
                                  ? Colors.orange[700]
                                  : Colors.green[700]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }

    Widget divider() {
      return Column(
        children: [
          SizedBox(height: 10),
          Divider(
            thickness: 0.3,
            color: subtitleColor,
          ),
          SizedBox(height: 10),
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
                color: primaryColor,
              ),
              SizedBox(width: 10),
              Text(
                "Customer Information",
                style: primaryTextStyle.copyWith(
                  fontSize: 16
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      );
    }

    Widget productItems() {
      return Container();
    }

    Widget paymentInformation() {
      return Container();
    }

    Widget content() {
      return Expanded(
        child: Container(
            width: double.infinity,
            color: bgColor3,
            child: Column(
              children: [
                basicInformation(),
                divider(),
                customerInformation(),
                divider(),
                productItems(),
                divider(),
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
