import 'package:carousel_slider/carousel_slider.dart';
import 'package:MushMagic/models/cart_model.dart';
import 'package:MushMagic/models/product_model.dart';
import 'package:MushMagic/providers/cart_provider.dart';
import 'package:MushMagic/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailHomePage extends StatefulWidget {
  const ProductDetailHomePage({super.key});

  static const routeName = '/home/product';

  @override
  _ProductDetailHomePageState createState() => _ProductDetailHomePageState();
}

class _ProductDetailHomePageState extends State<ProductDetailHomePage> {
  int currentIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductModel;
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    User? user = _auth.currentUser;

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
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Hurray :)',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Item added successfully',
                    style: secondaryTextStyle,
                  ),
                  const SizedBox(
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

    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 16 : 4,
        height: 4,
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? primaryColor : const Color(0xffC4C4C4),
        ),
      );
    }

    Widget header() {
      int index = -1;

      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.chevron_left,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CarouselSlider(
            items: args.images
                .map(
                  (image) => Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                      image,
                      width: MediaQuery.of(context).size.width,
                      height: 310,
                      fit: BoxFit.cover,
                                        ),
                    ),
                  )
                )
                .toList(),
            options: CarouselOptions(
              enableInfiniteScroll: false,
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: args.images.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          ),
        ],
      );
    }

    Widget content() {
      return SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 180,
          margin: const EdgeInsets.only(top: 17),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            color: bgColor1,
          ),
          child: Column(
            children: [
              // NOTE: HEADER
              Container(
                margin: EdgeInsets.only(
                  top: defaultMargin,
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          args.promotion.productId != "" ? Text(
                            "Promotion from ${args.promotion.name}",
                            style: primaryTextStyle.copyWith(
                              fontSize: 12,
                              color: const Color.fromRGBO(255,255,255,.5)
                            ),
                          ) : const SizedBox(),
                          args.promotion.productId != "" ? const SizedBox(height: 10) : const SizedBox(),
                          Text(
                            args.name,
                            style: primaryTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // NOTE: PRICE
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: 20,
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bgColor2,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price',
                      style: primaryTextStyle,
                    ),
                    Row(
                      children: [
                        Text(
                          'RM ${(args.price - args.discount)}',
                          style: priceTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        args.discount > 0 ? 
                          Text(
                          'RM ${args.price}',
                          style: priceTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: semiBold,
                            color: const Color.fromRGBO(255,255,255, .3),
                            decoration: TextDecoration.lineThrough,
                            decorationColor: const Color.fromRGBO(255,255,255, .3) 
                          ),
                        ) : const Text(""),
                      ],
                    )
                  ],
                ),
              ),

              // NOTE: DESCRIPTION
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      args.description,
                      style: subtitleTextStyle.copyWith(
                        fontWeight: light,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),

              // NOTE: BUTTONS
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(defaultMargin),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          height: 54,
                          child: TextButton(
                            onPressed: () {
                              cartProvider.addItem(CartModel(
                                  id: args.id,
                                  userId: user!.uid,
                                  qty: 1, 
                                  product: args));
                              showSuccessDialog();
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: primaryColor,
                            ),
                            child: Text(
                              'Add to Cart',
                              style: primaryTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor6,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
