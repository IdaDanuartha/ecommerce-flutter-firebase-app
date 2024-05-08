// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ecommerce_firebase/controllers/add_product_images_controller.dart';
import 'package:ecommerce_firebase/models/product_model.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({Key? key}) : super(key: key);

  static const routeName = '/product/edit';

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController =
      TextEditingController(text: "0");
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddProductImagesController addProductImagesController =
      Get.put(AddProductImagesController());

  @override
  void initState() {
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as ProductModel;

    _nameController.text = args.name;
    _priceController.text = args.price.toString();
    _discountController.text = args.discount.toString();
    _qtyController.text = args.qty.toString();
    _descriptionController.text = args.description;

    void updateProduct() async {
      // print(addProductImagesController.selectedImages);
      var updateProduct = await productProvider.update(args.id, {
        "name": _nameController.text,
        "price": double.parse(_priceController.text),
        "discount": double.parse(_discountController.text),
        "qty": int.parse(_qtyController.text),
        "description": _descriptionController.text,
        "images": [],
        "created_at": DateTime.now()
      });

      var nav = Navigator.of(context);
      nav.pop();
      nav.pop();

      if (updateProduct) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'Product updated successfully',
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
              'Failed to update product',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    Widget imageInput() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              addProductImagesController.showImagesPickerDialog(context);
            },
            child: const Text("Select Product Images"),
          )
        ],
      );
    }

    AppBar header() {
      return AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
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
          'Edit Product',
          style: primaryTextStyle.copyWith(fontSize: 18),
        ),
      );
    }

    Widget showImages() {
      return //show Images
          GetBuilder<AddProductImagesController>(
        init: AddProductImagesController(),
        builder: (imageController) {
          return imageController.selectedImages.length > 0
              ? Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: GridView.builder(
                    itemCount: imageController.selectedImages.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Image.file(
                            File(addProductImagesController
                                .selectedImages[index].path),
                            fit: BoxFit.cover,
                            height: 100,
                            width: 120,
                          ),
                          Positioned(
                            right: 24,
                            top: -3,
                            child: InkWell(
                              onTap: () {
                                imageController.removeImages(index);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white24,
                                child: Icon(
                                  Icons.close,
                                  color: primaryTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              : const SizedBox.shrink();
        },
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
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _nameController,
                      style: secondaryTextStyle,
                      decoration: InputDecoration(
                          hintText: 'Input product name',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
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
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _priceController,
                      style: secondaryTextStyle,
                      decoration: InputDecoration(
                          hintText: 'Input price',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
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
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _discountController,
                      style: secondaryTextStyle,
                      decoration: InputDecoration(
                          hintText: 'Input discount (optional)',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
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
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _qtyController,
                      style: secondaryTextStyle,
                      decoration: InputDecoration(
                          hintText: 'Input quantity',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      minLines: 8,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _descriptionController,
                      style: secondaryTextStyle,
                      decoration: InputDecoration(
                          hintText: 'Input description',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget addProductButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: updateProduct,
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            'Save changes',
            style:
                primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      backgroundColor: bgColor1,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 20
          ),
          child: Column(
          children: [
            imageInput(),
            showImages(),
            nameInput(),
            priceInput(),
            discountInput(),
            qtyInput(),
            descriptionInput(),
            addProductButton(),
          ],
        ),
        )),
    );
  }
}