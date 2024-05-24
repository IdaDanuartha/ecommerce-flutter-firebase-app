import 'package:ecommerce_firebase/models/order_item_model.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({super.key, required this.item});

  final OrderItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bgColor4,
      ),
      margin: EdgeInsets.only(bottom: 15),
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
                    Row(
                      children: [
                        Row(
                          children: [
                            item.discount > 0
                                ? Text(
                                    'RM ${item.price.toStringAsFixed(0)}',
                                    style: priceTextStyle.copyWith(
                                        fontSize: 10,
                                        color: Color.fromRGBO(255, 255, 255, .3),
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor:
                                            Color.fromRGBO(255, 255, 255, .3)),
                                  )
                                : Text(""),
                            item.discount > 0 ? SizedBox(width: 5) : SizedBox(),
                            Text(
                              "RM ${(item.price - item.discount).toStringAsFixed(0)}",
                              style: primaryTextStyle.copyWith(
                                  fontSize: 12, 
                                  color: priceColor,
                                )
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Text(
                          "x",
                          style: primaryTextStyle.copyWith(
                              fontSize: 12,
                              color: priceColor,
                            )
                        ),
                        SizedBox(width: 5),
                        Text(
                          item.qty.toString(),
                          style: primaryTextStyle.copyWith(
                              fontSize: 12,
                              color: priceColor,
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
