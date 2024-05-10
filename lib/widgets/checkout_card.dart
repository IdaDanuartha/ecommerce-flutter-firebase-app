import 'package:ecommerce_firebase/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';

class CheckoutCard extends StatelessWidget {
  CheckoutCard({super.key, required this.cart});

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: bgColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: NetworkImage(cart.images[0])),
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
                  cart.name,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text(
                      '\$${(cart.price - cart.discount).toStringAsFixed(2)}',
                      style: priceTextStyle,
                    ),
                    SizedBox(width: 5),
                    cart.discount > 0
                        ? Text(
                            '\$${cart.price}',
                            style: priceTextStyle.copyWith(
                                fontSize: 12,
                                color: Color.fromRGBO(255, 255, 255, .3),
                                decoration: TextDecoration.lineThrough,
                                decorationColor:
                                    Color.fromRGBO(255, 255, 255, .3)),
                          )
                        : Text(""),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            '${cart.qty.toString()} Items',
            style: secondaryTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
