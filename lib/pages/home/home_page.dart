import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:ecommerce_firebase/providers/user_provider.dart';
import 'package:ecommerce_firebase/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget  {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                          "Hello, ${userProvider.user!.name}",
                          style: primaryTextStyle.copyWith(
                              fontSize: 20, fontWeight: semiBold),
                        ),
                  Text(
                          "@${userProvider.user!.username}",
                          style: subtitleTextStyle.copyWith(fontSize: 16),
                        )
                ],
              ),
            ),
            ClipOval(
              child: Image.network(
                userProvider.user!.profileUrl != ""
                    ? userProvider.user!.profileUrl
                    : "https://picsum.photos/id/64/100",
                width: 54,
                height: 54,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    }

    Widget latestProducts() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Text(
              'Latest Products',
              style:
                  primaryTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 14,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: productProvider.products
                      .map((product) => ProductCard(product: product))
                      .toList(),
                ))
          )
        ],
      );
    }

    // return ListView(
    //   children: [
    //     header(),
    //     latestProducts(),
    //     // packages(),
    //     SizedBox(height: 50)
    //   ],
    // );
    
    return ListView(
      children: [
        header(),
        SizedBox(height: defaultMargin),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: Center(
            child: Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 20, // gap between lines
              children: productProvider.products
                        .map((product) => ProductCard(product: product))
                        .toList()
            ),
          ),
        ),
        SizedBox(height: defaultMargin),
      ],
    );
  }
}
