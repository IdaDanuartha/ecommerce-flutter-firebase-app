import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/models/product_model.dart';
import 'package:ecommerce_firebase/themes.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
  
    Widget image() {
      // return FutureBuilder(
      //   future: product.images[0],
      //   builder: (context, snapshot) {
      //     if(snapshot.connectionState == ConnectionState.done) {
      //       return Image.network(
      //         snapshot.data.toString(),
      //         width: 200,
      //         height: 150,
      //         fit: BoxFit.cover,
      //       );
      //     } else {
      //       return Image.asset(
      //           "assets/image_gallery.png",
      //           width: 300,
      //           height: 150,
      //           color: primaryTextColor,
      //         );
      //     }

      //   },
      // );
      
      return Image.network(
        product.images[0],
        width: 200,
        height: 150,
        fit: BoxFit.cover,
      );
    }
      
    return Row(children: [
      GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context,x
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             ProductPage(product: product)));
        },
        child: Container(
          width: 200,
          // height: 276,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: bgColor4,
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: image()
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      product.name,
                      style: primaryTextStyle.copyWith(
                          fontSize: 16, fontWeight: semiBold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "\$${product.price}",
                      style: priceTextStyle.copyWith(
                          fontSize: 14, fontWeight: medium),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${product.qty} left",
                          style: secondaryTextStyle.copyWith(fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: Image.asset(
                            'assets/icon_cart.png',
                            width: 18,
                            color: priceColor
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 20)
    ]);
  }
}
