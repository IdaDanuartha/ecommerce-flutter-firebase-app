// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:MushMagic/pages/admin/staff/add_staff_page.dart';
import 'package:MushMagic/pages/admin/staff/staff_detail.page.dart';
import 'package:MushMagic/providers/staff_provider.dart';
import 'package:flutter/material.dart';
import 'package:MushMagic/themes.dart';
import 'package:provider/provider.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({Key? key}) : super(key: key);

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
  
    Widget addButton() {
        return TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AddStaffPage.routeName);
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color.fromRGBO(172, 164, 232, .1),
              borderRadius: BorderRadius.circular(999)
            ),
            child: Image.asset(
              'assets/icon_add.png',
              width: 16,
              color: primaryColor,
            ),
          ),
        );
      }
    Widget content() {
      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 30),
          // decoration: BoxDecoration(
          //   borderRadius: const BorderRadius.all(Radius.circular(10)),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Data Staff",
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  addButton()
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: MediaQuery.of(context).size.width + 100,
                  child: Column(
                    children: [
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(4),
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
                                      horizontal: 16,
                                      vertical: 10
                                    ),
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
                                      horizontal: 12,
                                      vertical: 10
                                    ),
                                    child: Text(
                                      "Username",
                                      style: primaryTextStyle,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10
                                    ),
                                    child: Text(
                                      "Email",
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
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(4),
                        }, 
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: staffProvider.staff.isNotEmpty ? dataRows(staffProvider, context) : [
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        "No staff found",
                                        style: primaryTextStyle.copyWith(
                                          color: Color.fromRGBO(255,255,255,.7)
                                        ),
                                      ),
                                    ),
                                ),
                              ),
                            ]
                          )
                        ]
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

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          content()
        ],
      ),
    );
  }
}

List<TableRow> dataRows(StaffProvider staffProvider, BuildContext context) {
  return staffProvider.staff
      .map((user) => TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, StaffDetailPage.routeName, arguments: user);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    user.name,
                    style: primaryTextStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, StaffDetailPage.routeName, arguments: user);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    user.username,
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, StaffDetailPage.routeName, arguments: user);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    user.email,
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
            // TableCell(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       GestureDetector(
            //         onTap: () {},
            //         child: Image.asset(
            //           'assets/icon_edit.png',
            //           width: 16,
            //           color: Colors.amber[600],
            //         ),
            //       ),
            //       const SizedBox(width: 8),
            //       GestureDetector(
            //         onTap: () {},
            //         child: Image.asset(
            //           'assets/icon_delete.png',
            //           width: 16,
            //           color: Colors.red[400],
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ]))
      .toList();
}