// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_firebase/models/product_model.dart';
import 'package:ecommerce_firebase/pages/admin/products/edit_product_page.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  static const routeName = '/product/detail';

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as ProductModel;

    void deleteProduct() async {
      // print(addProductImagesController.selectedImages);
      var deleteProduct= await productProvider.delete(args.id);

      var nav = Navigator.of(context);
      nav.pop();
      nav.pop();

      if (deleteProduct) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'Product deleted successfully',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'Failed to delete product',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    AppBar header() {
      return AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: primaryTextColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: bgColor3,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Detail Product',
          style: primaryTextStyle.copyWith(fontSize: 18),
        ),
      );
    }

    Widget showImages() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Product Images',
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: medium, color: primaryTextColor),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 20,
              children: [
                for(var image in args.images ) ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                      image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
              ]
            )
          ],
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product name',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: primaryTextColor),
            ),
            const SizedBox(height: 12),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(args.name,
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .7))),
              ),
            )
          ],
        ),
      );
    }

    Widget priceInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: primaryTextColor),
            ),
            const SizedBox(height: 12),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("\$${args.price.toString()}",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .7))),
              ),
            )
          ],
        ),
      );
    }

    Widget discountInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discount',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: primaryTextColor),
            ),
            const SizedBox(height: 12),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    args.discount > 0 ? args.discount.toString() : "\$0",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .7))),
              ),
            )
          ],
        ),
      );
    }

    Widget qtyInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quantity',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: primaryTextColor),
            ),
            const SizedBox(height: 12),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("${args.qty.toString()} items",
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .7))),
              ),
            )
          ],
        ),
      );
    }

    Widget descriptionInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: primaryTextColor),
            ),
            const SizedBox(height: 12),
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(args.description,
                    style: primaryTextStyle.copyWith(
                        color: const Color.fromRGBO(255, 255, 255, .7))),
              ),
            )
          ],
        ),
      );
    }

    Widget actionButtons() {
      return Row(
        children: [
          Container(
            height: 50,
            // width: double.infinity,
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProductPage.routeName,
                    arguments: args);
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.orange[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                'Edit',
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold),
              ),
            ),
          ),
          SizedBox(width: 20),
          Container(
            height: 50,
            // width: double.infinity,
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      scrollable: true,
                      backgroundColor: bgColor1,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delete Confirmation",
                                style: primaryTextStyle.copyWith(
                                    fontWeight: bold, fontSize: 20)),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                      insetPadding: const EdgeInsets.all(10),
                      content: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Text(
                              "Confirmation Product Deletion: Are you sure you want to delete this product? This action cannot be reversed and the product will permanently deleted from the system",
                              style: primaryTextStyle.copyWith(
                                fontSize: 14,
                                color: Color.fromRGBO(255, 255, 255, .5)
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.grey[700],
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10))),
                                    child: Text(
                                      'Cancel',
                                      style: primaryTextStyle.copyWith(
                                          fontSize: 16, fontWeight: semiBold),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      deleteProduct();
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.red[500],
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10))),
                                    child: Text(
                                      'Yes, delete it',
                                      style: primaryTextStyle.copyWith(
                                          fontSize: 16, fontWeight: semiBold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                'Delete',
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold),
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: header(),
      backgroundColor: bgColor1,
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        child: Column(
          children: [
            actionButtons(),
            showImages(),
            nameInput(),
            priceInput(),
            discountInput(),
            qtyInput(),
            descriptionInput(),
          ],
        ),
      )),
    );
  }
}
