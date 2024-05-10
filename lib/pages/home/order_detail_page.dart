import 'package:ecommerce_firebase/helpers/my_separator.dart';
import 'package:ecommerce_firebase/models/order_model.dart';
import 'package:ecommerce_firebase/widgets/order_item_card.dart';
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
                crossAxisAlignment: CrossAxisAlignment.end,
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
                crossAxisAlignment: CrossAxisAlignment.end,
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
                style: primaryTextStyle.copyWith(
                  fontSize: 16
                ),
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
                      color: Color.fromRGBO(255, 255, 255, .5),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 200,
                    child: Text(
                      args.customerName,
                      style: primaryTextStyle.copyWith(fontSize: 16),
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
                        color: Color.fromRGBO(255, 255, 255, .5)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    args.phone,
                    style: primaryTextStyle.copyWith(fontSize: 16),
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
                style: primaryTextStyle.copyWith(
                  fontSize: 16
                ),
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
                      color: Color.fromRGBO(255, 255, 255, .5),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 200,
                    child: Text(
                      args.address.country,
                      style: primaryTextStyle.copyWith(fontSize: 16),
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
                    "Province",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    args.address.province,
                    style: primaryTextStyle.copyWith(fontSize: 16),
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
                      color: Color.fromRGBO(255, 255, 255, .5),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 200,
                    child: Text(
                      args.address.city,
                      style: primaryTextStyle.copyWith(fontSize: 16),
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
                    "Subdistrict",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .5)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    args.address.subdistrict,
                    style: primaryTextStyle.copyWith(fontSize: 16),
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
                      color: Color.fromRGBO(255, 255, 255, .5),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Text(
                      args.address.details,
                      style: primaryTextStyle.copyWith(fontSize: 16),
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
      return Column(
        children: [
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
                style: primaryTextStyle.copyWith(
                  fontSize: 16
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...args.items.map((item) => OrderItemCard(item: item)).toList(),
        ]
      );
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
                style: primaryTextStyle.copyWith(
                  fontSize: 16
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: primaryTextStyle.copyWith(fontSize: 16),
              ),
              Text(
                "\$${args.subTotal}",
                style: primaryTextStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount",
                style: primaryTextStyle.copyWith(fontSize: 16),
              ),
              Text(
                "-\$${args.totalDiscount}",
                style: primaryTextStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Fee",
                style: primaryTextStyle.copyWith(fontSize: 16),
              ),
              Text(
                "\$${args.deliveryFee}",
                style: primaryTextStyle.copyWith(fontSize: 16),
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
                style: primaryTextStyle.copyWith(fontSize: 16),
              ),
              Text(
                "\$${args.subTotal + args.deliveryFee - args.totalDiscount}",
                style: primaryTextStyle.copyWith(fontSize: 16),
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
