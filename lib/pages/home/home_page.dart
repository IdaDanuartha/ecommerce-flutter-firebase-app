import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/models/user_model.dart';
import 'package:ecommerce_firebase/providers/auth_provider.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:ecommerce_firebase/widgets/product_card.dart';
import 'package:ecommerce_firebase/widgets/product_tile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, ${user.name}",
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold
                    ),
                  ),
                  Text(
                    '@${user.username}',
                    style: subtitleTextStyle.copyWith(
                      fontSize: 16
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    user.profilePhotoUrl
                  )
                )
              ),
            )
          ],
        ),
      );  
    }
    
    Widget categories() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10
                ),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryColor
                ),
                child: Text(
                  'All Shoes',
                  style: primaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10
                ),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: subtitleColor
                  ),
                  color: transparentColor
                ),
                child: Text(
                  'Running',
                  style: primaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                    color: subtitleColor
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10
                ),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: subtitleColor
                  ),
                  color: transparentColor
                ),
                child: Text(
                  'Training',
                  style: primaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                    color: subtitleColor
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10
                ),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: subtitleColor
                  ),
                  color: transparentColor
                ),
                child: Text(
                  'Basketball',
                  style: primaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                    color: subtitleColor
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10
                ),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: subtitleColor
                  ),
                  color: transparentColor
                ),
                child: Text(
                  'Hiking',
                  style: primaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                    color: subtitleColor
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget popularProducts() {
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
              'Popular Products',
              style: primaryTextStyle.copyWith(
                fontSize: 22,
                fontWeight: semiBold
              ),
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
                children: productProvider.products.map(
                  (product) => ProductCard(product: product)
                ).toList()
              ),
            ),
          )
        ],
      );
    }

    Widget newArrivals() {
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
              'New Arrivals',
              style: primaryTextStyle.copyWith(
                fontSize: 22,
                fontWeight: semiBold
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 14,
            ),
            child: Column(
              children: [
                ProductTile(product: productProvider.products[0]),
                ProductTile(product: productProvider.products[1]),
                ProductTile(product: productProvider.products[2]),
                ProductTile(product: productProvider.products[3]),
              ]
            )
          )
        ],
      );
    }

    return ListView(
      children: [
        header(),
        categories(),
        popularProducts(),
        newArrivals(),
      ],
    );
  }
}