import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/models/product_model.dart';
import 'package:ecommerce_firebase/providers/wishlist_provider.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: 10, left: 12, right: 14, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: bgColor4),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.galleries[0].url,
              width: 60,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold
                  ),
                ),
                Text(
                  '\$${product.price}',
                  style: priceTextStyle
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              wishlistProvider.setProduct(product);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: alertColor,
                  duration: Duration(milliseconds: 800),
                  content: Text(
                    'Product has been removed from the wishlist',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            child: Image.asset(
              'assets/button_wishlist_blue.png',
              width: 34,
            ),
          )
        ],
      ),
    );
  }
}
