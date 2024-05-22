// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/controllers/add_product_images_controller.dart';
import 'package:ecommerce_firebase/helpers/upload_image.dart';
import 'package:ecommerce_firebase/models/promotion_model.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:ecommerce_firebase/widgets/loading_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  static const routeName = '/product/add';

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _productIdController = TextEditingController();
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

  bool isLoading = false;
  
  List<DropdownMenuItem<String>> dropdownItems(ProductProvider productProvider) {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Select Product"), value: "Select Product"),
    ];

    for (var product in productProvider.products) {
      if(product.promotion.productId == "") {
        menuItems.add(DropdownMenuItem(child: Text(product.name), value: product.id));
      }
    }

    return menuItems;
  }

  
  String productSelected = "Select Product";

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    List<DropdownMenuItem<String>> items = dropdownItems(productProvider);
    _productIdController.text = productSelected;

    void storeProduct() async {
      setState(() {
        isLoading = true;
      });

      List<String> imageUrls = [];
      // List to store all futures returned by uploadSingleImage
      List<Future<String>> uploadFutures = [];

      for (var image in addProductImagesController.selectedImages) {
        try {
          // Upload each image and wait for the result
          String imageUrl = await uploadSingleImage(image, "products");
          imageUrls.add(imageUrl);
        } catch (error) {
          print('Error uploading image: $error');
          // Handle the error (for example, show a message to the user)
        }
      }

      PromotionModel? promotionModel;

      // if(_productIdController.text != "Select Product") {
        await FirebaseFirestore.instance.collection("products").doc(_productIdController.text).get().then(
        (DocumentSnapshot doc) {
          print(doc.data());
          if(doc.data() != null) {
              final data = doc.data() as Map<String, dynamic>;
              promotionModel = PromotionModel.fromJson({
                "product_id": doc.id,
                "name": data["name"]
              });
            } else {
              promotionModel = PromotionModel.fromJson({
                "product_id": "",
                "name": ""
              });
            }
        },
        onError: (e) {
          print("Error completing: $e");
          promotionModel = PromotionModel.fromJson({
            "product_id": "",
            "name": ""
          });
        },
      );
      // }

      try {
        // Now that imageUrls is populated, proceed with the rest of the code
        var newProduct = await productProvider.store({
          "promotion": {
            "product_id": promotionModel!.productId, 
            "name": promotionModel!.name, 
          },
          "name": _nameController.text,
          "price": double.parse(_priceController.text),
          "discount": double.parse(_discountController.text),
          "qty": int.parse(_qtyController.text),
          "description": _descriptionController.text,
          "images": imageUrls,
          "created_at": DateTime.now(),
        });

        if (newProduct) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: successColor,
              duration: const Duration(milliseconds: 2500),
              content: const Text(
                'Product created successfully',
                textAlign: TextAlign.center,
              ),
            ),
          );

          addProductImagesController.selectedImages.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: alertColor,
              duration: const Duration(milliseconds: 2500),
              content: const Text(
                'Failed to create product',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'Error uploading product images',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
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
          'Add Product',
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
                  height: imageController.selectedImages.length > 3 ? 180 : 100,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: GridView.builder(
                    itemCount: imageController.selectedImages.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              File(addProductImagesController
                                  .selectedImages[index].path),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 120,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
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

    Widget selectProductInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Promotion (Optional)',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: primaryTextColor),
            ),
            const SizedBox(height: 12),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide:
                              //       BorderSide(color: Colors.blue, width: 2),
                              //   borderRadius: BorderRadius.circular(20),
                              // ),
                              // border: OutlineInputBorder(
                              //   borderSide:
                              //       BorderSide(color: Colors.blue, width: 2),
                              //   borderRadius: BorderRadius.circular(20),
                              // ),
                              // filled: true,
                              // fillColor: Colors.blueAccent,
                            ),
                            elevation: 0,
                            dropdownColor: bgColor3,
                            style: TextStyle(
                              color: primaryTextColor,
                            ),
                            value: productSelected,
                            onChanged: (String? newValue) {
                              setState(() {
                                productSelected = newValue!;
                              });
                            },
                            items: items))
                  ],
                ),
              ),
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
          onPressed: storeProduct,
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            'Create',
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
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        child: Column(
          children: [
            imageInput(),
            showImages(),
            selectProductInput(),
            nameInput(),
            priceInput(),
            discountInput(),
            qtyInput(),
            descriptionInput(),
            isLoading
                ? LoadingButton(text: "Creating", marginTop: 20)
                : addProductButton(),
          ],
        ),
      )),
    );
  }
}
