import 'package:ecommerce_firebase/models/cart_model.dart';
import 'package:ecommerce_firebase/pages/home/product_detail_page.dart';
import 'package:ecommerce_firebase/providers/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/models/product_model.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    User? user = FirebaseAuth.instance.currentUser;

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: bgColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/icon_success.png',
                    width: 100,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Hurray :)',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Item added successfully',
                    style: secondaryTextStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   width: 154,
                  //   height: 44,
                  //   child: TextButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, CartPage.routeName);
                  //     },
                  //     style: TextButton.styleFrom(
                  //       backgroundColor: primaryColor,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //     ),
                  //     child: Text(
                  //       'View My Cart',
                  //       style: primaryTextStyle.copyWith(
                  //         fontSize: 16,
                  //         fontWeight: medium,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
    }

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
        width: double.infinity,
        height: 120,
        fit: BoxFit.cover,
      );
    }

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailHomePage.routeName, arguments: product);
        },
        child: Container(
          width: MediaQuery.of(context).size.width - (2 * 120),
          // height: 276,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(10),
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
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      product.name,
                      style: primaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: semiBold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "\$${(product.price - product.discount).toStringAsFixed(2)}",
                          style: priceTextStyle.copyWith(
                              fontSize: 12, fontWeight: medium),
                        ),
                        SizedBox(width: 5),
                        product.discount > 0 ? 
                          Text(
                          '\$${product.price}',
                          style: priceTextStyle.copyWith(
                            fontSize: 10,
                            color: Color.fromRGBO(255,255,255, .3),
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Color.fromRGBO(255,255,255, .3) 
                          ),
                        ) : Text(""),
                      ],
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
                            cartProvider.addItem(CartModel(
                                id: product.id,
                                userId: user!.uid,
                                qty: 1,
                                product: product));
                            showSuccessDialog();
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
      );
  }
}
