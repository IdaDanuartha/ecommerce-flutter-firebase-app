import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/models/product_model.dart';
import 'package:ecommerce_firebase/pages/product_page.dart';
import 'package:ecommerce_firebase/themes.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage(product: product))
        );
      },
      child: Container(
        width: 215,
        height: 278,
        margin: EdgeInsets.only(right: defaultMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffECEDEF),
        ),          
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.network(
              product.galleries[0].url,
              width: 215,
              height: 150,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.name,
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    product.name,
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6,),
                  Text(
                    "\$${product.price}",
                    style: priceTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
