// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:ecommerce_firebase/controllers/add_product_images_controller.dart';
import 'package:ecommerce_firebase/models/product_model.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool sort = true;
  List<ProductModel>? filterData;

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterData!.sort((a, b) => a.name.compareTo(b.name));
      } else {
        filterData!.sort((a, b) => b.name.compareTo(a.name));
      }
    }

    if (columnIndex == 1) {
      if (ascending) {
        filterData!.sort((a, b) => a.price.compareTo(b.price));
      } else {
        filterData!.sort((a, b) => b.price.compareTo(a.price));
      }
    }
  }

  AddProductImagesController addProductImagesController =
      Get.put(AddProductImagesController());

  @override
  void initState() {
    // filterData = myData;
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget imageInput() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              addProductImagesController.showImagesPickerDialog(context);
            },
            child: Text("Select Product Images"),
          )
        ],
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
                  margin: EdgeInsets.symmetric(vertical: 20),
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
              : SizedBox.shrink();
        },
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product name',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: primaryTextColor),
            ),
            SizedBox(height: 12),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: Color(0xFF797979))),
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
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: primaryTextColor),
            ),
            SizedBox(height: 12),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: Color(0xFF797979))),
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
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discount',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: primaryTextColor),
            ),
            SizedBox(height: 12),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: Color(0xFF797979))),
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
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quantity',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: primaryTextColor),
            ),
            SizedBox(height: 12),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: Color(0xFF797979))),
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
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: primaryTextColor),
            ),
            SizedBox(height: 12),
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: Color(0xFF797979))),
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
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            'Add new product',
            style:
                primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
                      Text("Add New Product",
                          style: primaryTextStyle.copyWith(
                              fontWeight: bold, fontSize: 24)),
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
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      imageInput(),
                      showImages(),
                      nameInput(),
                      priceInput(),
                      discountInput(),
                      qtyInput(),
                      descriptionInput(),
                    ],
                  ),
                ),
                actions: [addProductButton()],
              );
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
        tooltip: "Add product",
        backgroundColor: Color.fromRGBO(172, 164, 232, 1),
        child: Image.asset(
          'assets/icon_add.png',
          width: 20,
          color: primaryColor,
        ),
      ),
      backgroundColor: bgColor1,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 50),
          // decoration: BoxDecoration(
          //   borderRadius: const BorderRadius.all(Radius.circular(10)),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data Products",
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        }, 
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                              decoration: BoxDecoration(color: bgColor3),
                              children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Name",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Price",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Qty",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        }, 
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: dataRows(productProvider),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //     width: double.infinity,
              //     child: Theme(
              //       data: ThemeData.dark(useMaterial3: false)
              //           .copyWith(cardColor: bgColor3),
              //       child: PaginatedDataTable(
              //         sortColumnIndex: 0,
              //         sortAscending: sort,
              //         header: Container(
              //           margin: EdgeInsets.all(0),
              //           padding: const EdgeInsets.all(5),
              //           child: TextField(
              //             controller: controller,
              //             decoration: const InputDecoration(
              //                 hintText: "Enter something to filter"),
              //             onChanged: (value) {
              //               // setState(() {
              //               //   myData = filterData!
              //               //       .where((element) =>
              //               //           element.name!.contains(value))
              //               //       .toList();
              //               // });
              //             },
              //           ),
              //         ),
              //         source: RowSource(
              //           productProvider: productProvider,
              //         ),
              //         rowsPerPage: 5,
              //         columnSpacing: 20,
              //         columns: [
              //           DataColumn(
              //               label: const Text(
              //                 "Name",
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.w600, fontSize: 14),
              //               ),
              //               onSort: (columnIndex, ascending) {
              //                 setState(() {
              //                   sort = !sort;
              //                 });

              //                 onsortColum(columnIndex, ascending);
              //               }),
              //           DataColumn(
              //               label: const Text(
              //                 "Price",
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.w600, fontSize: 14),
              //               ),
              //               onSort: (columnIndex, ascending) {
              //                 setState(() {
              //                   sort = !sort;
              //                 });

              //                 onsortColum(columnIndex, ascending);
              //               }),
              //           const DataColumn(
              //             label: Text(
              //               "Qty",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.w600, fontSize: 14),
              //             ),
              //           ),
              //           const DataColumn(
              //             label: Text(
              //               "Action",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.w600, fontSize: 14),
              //             ),
              //           ),
              //         ],
              //       ),
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}

// class RowSource extends DataTableSource {
//   late final ProductProvider productProvider;

//   RowSource({required this.productProvider});

//   @override
//   DataRow? getRow(int index) {
//     if (index >= 3) {
//       return null;
//     }

//     // final item = productProvider.products[0];

//     return DataRow(cells: [
//       DataCell(Text("Danu")),
//       DataCell(Text("9000")),
//       DataCell(Text("10")),
//     ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => 3;

//   @override
//   int get selectedRowCount => 0;
// }

List<TableRow> dataRows(ProductProvider productProvider) {
  return productProvider.products
      .map((product) => TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  product.name,
                  style: primaryTextStyle,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  product.price.toString(),
                  style: primaryTextStyle,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  product.qty.toString(),
                  style: primaryTextStyle,
                ),
              ),
            ),
          ]))
      .toList();
}

// DataRow recentFileDataRow(var product) {
//   return DataRow(
//     cells: [
//       DataCell(Text(product.name)),
//         DataCell(Text(product.price.toString())),
//         DataCell(Text(product.qty.toString())),
//         DataCell(Row(
//           children: [
//             GestureDetector(
//               onTap: () {},
//               child: Image.asset(
//                 'assets/icon_edit.png',
//                 width: 16,
//                 color: Colors.amber[600],
//               ),
//             ),
//             SizedBox(width: 8),
//             GestureDetector(
//               onTap: () {},
//               child: Image.asset(
//                 'assets/icon_delete.png',
//                 width: 16,
//                 color: Colors.red[400],
//               ),
//             ),
//           ],
//         )),
//     ]
//   );
// }