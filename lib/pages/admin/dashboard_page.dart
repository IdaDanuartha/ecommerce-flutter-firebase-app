import 'package:MushMagic/pages/admin/products/product_detail_page.dart';
import 'package:MushMagic/providers/order_provider.dart';
import 'package:MushMagic/providers/product_provider.dart';
import 'package:MushMagic/providers/staff_provider.dart';
import 'package:MushMagic/providers/user_provider.dart';
import 'package:MushMagic/widgets/charts/bar_chart.dart';
import 'package:MushMagic/widgets/charts/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:MushMagic/themes.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);

    int productCount = productProvider.products.length;
    int staffCount = staffProvider.staff.length;
    int customerCount = userProvider.customers.length;
    int orderCount = orderProvider.orders.length;

    String userRole = userProvider.user!.role;

    List<double> ordersMonthly = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

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
                        fontSize: 24, fontWeight: semiBold),
                  ),
                  Text(
                    "@${userProvider.user!.username}",
                    style: subtitleTextStyle.copyWith(fontSize: 16),
                  ),
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
                fit:BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> dataAdmin = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Products",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  productCount > 0 ? productCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Transactions",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  orderCount > 0 ? orderCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Staff",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  staffCount > 0 ? staffCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Customers",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  customerCount > 0 ? customerCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      )
    ];

    List<Widget> dataStaff = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Customers",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  customerCount > 0 ? customerCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgColor3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "Total Transactions",
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, color: Color.fromRGBO(255, 255, 255, .5)),
                ),
                SizedBox(height: 10),
                Text(
                  orderCount > 0 ? orderCount.toString() : "-",
                  style: primaryTextStyle.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
    Widget dataCount() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        width: MediaQuery.of(context).size.width,
        child: Column(children: userRole == "admin" ? dataAdmin : dataStaff),
      );
    }

    Widget barChart() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: bgColor3, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Monthly Transactions",
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            SizedBox(
              height: 300,
              child: BarChartSample3(
                  weeklyTransactions: orderProvider.ordersMonthly.isNotEmpty
                      ? orderProvider.ordersMonthly
                      : ordersMonthly),
            ),
          ],
        ),
      );
    }

    Widget pieChart() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: bgColor3, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Monthly Transactions",
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 300,
              child: PieChartSample2(),
            ),
          ],
        ),
      );
    }
    
    Widget bestSellingProduct() {
      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          // decoration: BoxDecoration(
          //   borderRadius: const BorderRadius.all(Radius.circular(10)),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Best Selling Products",
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 25,
                  child: Column(
                    children: [
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(2),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    child: Text(
                                      "Total Revenue",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                      Table(
                          columnWidths: const {
                            0: FlexColumnWidth(3),
                            1: FlexColumnWidth(2),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: productProvider.products.isNotEmpty
                              ? dataRows(productProvider, context)
                              : [
                                  TableRow(children: [
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            "No product found",
                                            style: primaryTextStyle.copyWith(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, .7)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])
                                ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: ListView(
        children: [
          header(),
          dataCount(),
          barChart(),
          // pieChart()
          bestSellingProduct(),
          SizedBox(height: 30)
        ],
      ),
    );
  }
}

List<TableRow> dataRows(ProductProvider productProvider, BuildContext context) {
  return productProvider.bestSellingProduct
      .map((product) => TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailPage.routeName,
                      arguments: product);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    product.name,
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailPage.routeName,
                      arguments: product);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "RM ${product.totalRevenue.toString()}",
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
          ]))
      .toList();
}
