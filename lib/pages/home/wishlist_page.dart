import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:ecommerce_firebase/widgets/wishlist_card.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    // WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    Widget header() {
      return Container(
        child: AppBar(
          backgroundColor: bgColor1,
          centerTitle: true,
          title: Text(
            "Favorite Shoes",
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: medium
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
      );
    }

    Widget emptyWishlist() {
      return Expanded(
        child: Container(
          width: double.infinity,        
          color: bgColor3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icon_wishlist.png", width: 74, color: secondaryColor),
              SizedBox(height: 20),
              Text("You don't have dream shoes?", style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium
              ),),
              SizedBox(height: 12),
              Text(
                "Let's find your favorite shoes",
                style: secondaryTextStyle,
              ),
              SizedBox(height: 20),
              Container(
                height: 44,
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/home');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                  child: Text(
                    'Explore Store',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          width: double.infinity,        
          color: bgColor3,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin
            ),
            // children: wishlistProvider.wishlist.map(
            //   (product) => WishlistCard(product: product)
            // ).toList()
          )
        ),
      );
    }

    return Column(
      children: [
        header(),
        // wishlistProvider.wishlist.length == 0 ? emptyWishlist() : content()
      ],
    );
  }
}