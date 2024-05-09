import 'package:ecommerce_firebase/models/order_model.dart';
import 'package:ecommerce_firebase/providers/order_provider.dart';
import 'package:ecommerce_firebase/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

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

    // Widget content() {
    //   return Expanded(
    //     child: Container(
    //       width: double.infinity,
    //       color: bgColor3,
    //       child: ListView(
    //         padding: EdgeInsets.symmetric(
    //           horizontal: defaultMargin
    //         ),
    //         children: orderProvider.orders.map(
    //           (order) => OrderCard(order: order)
    //         ).toList()
    //       )
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: header(),
      backgroundColor: bgColor3,
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
      )),
    );
  }
}
