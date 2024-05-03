import 'package:ecommerce_firebase/helpers/get_download_url.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/models/product_model.dart';
import 'package:ecommerce_firebase/themes.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
  
    Widget image() {
      return FutureBuilder(
        future: getDownloadURL().getUrl(product.images[0]),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            return Image.network(
              snapshot.data.toString(),
              width: 300,
              height: 150,
              fit: BoxFit.cover,
            );
          }

          return const Text("Something went wrong");
        },
      );
    }
      
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,x
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             ProductPage(product: product)));
              },
              child: Container(
                width: 300,
                height: 276,
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(20),
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
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          Text(
                            product.name,
                            style: primaryTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "\$${product.price}",
                            style: priceTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "${product.qty} left",
                            style: secondaryTextStyle.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 20)
    ]);
  }
}
