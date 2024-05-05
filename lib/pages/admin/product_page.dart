// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';

class Data {
  String? name;
  int? price;
  int? qty;

  Data({required this.name, required this.price, required this.qty});
}

List<Data> myData = [
  Data(name: "Khaliq", price: 09876543, qty: 28),
  Data(name: "David", price: 6464646, qty: 30),
  Data(name: "Kamal", price: 8888, qty: 32),
  Data(name: "Ali", price: 3333333, qty: 33),
  Data(name: "Muzal", price: 987654556, qty: 23),
  Data(name: "Taimu", price: 46464664, qty: 24),
  Data(name: "Mehdi", price: 5353535, qty: 36),
  Data(name: "Rex", price: 244242, qty: 38),
  Data(name: "Alex", price: 323232323, qty: 29),
];

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool sort = true;
  List<Data>? filterData;

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterData!.sort((a, b) => a.name!.compareTo(b.name!));
      } else {
        filterData!.sort((a, b) => b.name!.compareTo(a.name!));
      }
    }

    if (columnIndex == 1) {
      if (ascending) {
        filterData!.sort((a, b) => a.price!.compareTo(b.price!));
      } else {
        filterData!.sort((a, b) => b.price!.compareTo(a.price!));
      }
    }
  }

  @override
  void initState() {
    filterData = myData;
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
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
                  SizedBox(
                      width: double.infinity,
                      child: Theme(
                        data: ThemeData.dark(useMaterial3: false).copyWith(cardColor: bgColor3),
                        child: PaginatedDataTable(
                          sortColumnIndex: 0,
                          sortAscending: sort,
                          header: Container(
                            margin: EdgeInsets.all(0),
                            padding: const EdgeInsets.all(5),
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                  hintText: "Enter something to filter"),
                              onChanged: (value) {
                                setState(() {
                                  myData = filterData!
                                      .where((element) =>
                                          element.name!.contains(value))
                                      .toList();
                                });
                              },
                            ),
                          ),
                          source: RowSource(
                            myData: myData,
                            count: myData.length,
                          ),
                          rowsPerPage: 5,
                          columnSpacing: 20,
                          columns: [
                            DataColumn(
                                label: const Text(
                                  "Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 14),
                                ),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    sort = !sort;
                                  });
        
                                  onsortColum(columnIndex, ascending);
                                }
                            ),
                            DataColumn(
                              label: const Text(
                                "Price",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              onSort: (columnIndex, ascending) {
                                  setState(() {
                                    sort = !sort;
                                  });
        
                                  onsortColum(columnIndex, ascending);
                                }
                            ),
                            const DataColumn(
                              label: Text(
                                "Qty",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                "Action",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
      ),
    );
  }
}

class RowSource extends DataTableSource {
  var myData;
  final count;
  RowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index]);
    } else
      return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRow(var data) {
  return DataRow(
    cells: [
      DataCell(Text(data.name ?? "Name")),
      DataCell(Text(data.price.toString())),
      DataCell(Text(data.qty.toString())),
      DataCell(
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/icon_edit.png',
                width: 16,
                color: Colors.amber[600],
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/icon_delete.png',
                width: 16,
                color: Colors.red[400],
              ),
            ),
          ],
        )
      ),
    ],
  );
}
