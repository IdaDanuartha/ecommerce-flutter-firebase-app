import 'package:MushMagic/providers/order_provider.dart';
import 'package:MushMagic/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:MushMagic/themes.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  static const routeName = '/home/orders';

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    Widget header() {
      return AppBar(
          backgroundColor: bgColor1,
          centerTitle: true,
          title: Text(
            "My Orders",
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: medium
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: null,
        );
    }

    Widget emptyOrder() {
      return Container(
        width: double.infinity,    
        margin: EdgeInsets.only(top: 180),
        color: bgColor3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icon_empty_order.png", width: 74, color: secondaryColor),
            const SizedBox(height: 20),
            Text("No Orders Yet", style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium
            ),),
            const SizedBox(height: 12),
            Text(
              "It's seem that you don't have any orders yet",
              style: secondaryTextStyle,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 44,
              child: TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/home');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10
                  ),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
                child: Text(
                  'Explore Product',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,    
        // height: 1000,    
        color: bgColor3,
        // child: ListView(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: defaultMargin
        //   ),
        //   children: orderProvider.orders.map(
        //     (order) => OrderCard(order: order)
        //   ).toList()
        // )
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin
          ),
          child: Wrap(
                spacing: 8.0,
                children: orderProvider.orders
                          .map((order) => OrderCard(order: order))
                          .toList()
              ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            orderProvider.orders.isEmpty ?
            emptyOrder() :
            content(),
          ],
        ),
      ),
    );
  }
}