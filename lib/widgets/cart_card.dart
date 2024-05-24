import 'package:ecommerce_firebase/models/cart_model.dart';
import 'package:ecommerce_firebase/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {  
  const CartCard({super.key, required this.cart});

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: bgColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
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
                      cart.product.images[0],
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
                      cart.product.name,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'RM ${(cart.product.price - cart.product.discount)}',
                          style: priceTextStyle,
                        ),
                        SizedBox(width: 5),
                        cart.product.discount > 0 ? 
                          Text(
                          'RM ${cart.product.price}',
                          style: priceTextStyle.copyWith(
                            fontSize: 12,
                            color: Color.fromRGBO(255,255,255, .3),
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Color.fromRGBO(255,255,255, .3) 
                          ),
                        ) : Text(""),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      cartProvider.increaseQty(cart);
                    },
                    child: Image.asset(
                      'assets/button_add.png',
                      width: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    cart.qty.toString(),
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      cartProvider.decreaseQty(cart);
                    },
                    child: Image.asset(
                      'assets/button_min.png',
                      width: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              cartProvider.removeItem(cart);
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icon_remove.png',
                  width: 10,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'Remove',
                  style: alertTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
