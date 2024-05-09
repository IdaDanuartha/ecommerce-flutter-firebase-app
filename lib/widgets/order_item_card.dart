import 'package:ecommerce_firebase/models/order_item_model.dart';
import 'package:ecommerce_firebase/models/order_model.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({super.key, required this.item});

  final OrderItemModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        item.product.images[0],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product.name,
                        style: primaryTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 15, overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "\$${item.price.toString()}",
                        style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            color: Color.fromRGBO(255, 255, 255, .6)),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 8,
                //     vertical: 4
                //   ),
                //   decoration: BoxDecoration(
                //     color: order.status == 1 ? Colors.amber[100] : order.status == 2 ? Colors.orange[100] : Colors.green[100],
                //     borderRadius: BorderRadius.circular(4)
                //   ),
                //   child: Text(
                //     order.status == 1 ? "Preparing Order" : order.status == 2 ? "Out for Delivery" : "Delivered",
                //     style: primaryTextStyle.copyWith(
                //       fontSize: 11,
                //       fontWeight: FontWeight.bold,
                //       color: order.status == 1 ? Colors.amber[700] : order.status == 2 ? Colors.orange[700] : Colors.green[700]
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
