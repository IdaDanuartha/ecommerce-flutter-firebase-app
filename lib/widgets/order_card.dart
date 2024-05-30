import 'package:MushMagic/models/order_model.dart';
import 'package:MushMagic/pages/home/order_detail_page.dart';
import 'package:MushMagic/themes.dart';
import 'package:MushMagic/widgets/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, OrderDetailPage.routeName, arguments: order);
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${order.code}",
                        style: primaryTextStyle.copyWith(
                            fontWeight: semiBold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Placed on ${DateFormat.yMMMd().format(order.createdAt.toDate())}',
                        style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            color: const Color.fromRGBO(255, 255, 255, .6)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: order.status == 1 ? Colors.amber[100]
                           : order.status == 2 ? Colors.orange[100] 
                           : order.status == 3 ? Colors.green[100] : Colors.red[100],
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    order.status == 1
                        ? "Preparing Order"
                        : order.status == 2 ? "Out for Delivery"
                        : order.status == 3 ? "Delivered" : "Cancelled",
                    style: primaryTextStyle.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: order.status == 1
                            ? Colors.amber[700]
                            : order.status == 2 ? Colors.orange[700]
                            : order.status == 3 ? Colors.green[700] : Colors.red[700]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              thickness: 0.3,
              color: subtitleColor,
            ),
            const SizedBox(height: 10),
            OrderItemCard(item: order.items.first),
            (order.items.length - 1) > 0
                ? Text(
                    "+${order.items.length - 1} other products",
                    style: primaryTextStyle.copyWith(
                        fontSize: 12,
                        color: const Color.fromRGBO(255, 255, 255, .5)),
                  )
                : const Text(""),
            (order.items.length - 1) > 0 ? const SizedBox(height: 20) : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Price:",
                      style: primaryTextStyle.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "RM ${(order.subTotal - order.totalDiscount + order.deliveryFee).toStringAsFixed(0)}",
                      style: priceTextStyle,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Payment Method:",
                      style: primaryTextStyle.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      order.paymentMethod,
                      style: priceTextStyle,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
