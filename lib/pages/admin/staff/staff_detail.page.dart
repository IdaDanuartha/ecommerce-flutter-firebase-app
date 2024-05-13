// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_firebase/models/user_model.dart';
import 'package:ecommerce_firebase/pages/admin/products/edit_product_page.dart';
import 'package:ecommerce_firebase/pages/admin/staff/edit_staff_page.dart';
import 'package:ecommerce_firebase/providers/staff_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class StaffDetailPage extends StatefulWidget {
  const StaffDetailPage({Key? key}) : super(key: key);

  static const routeName = '/staff/detail';

  @override
  State<StaffDetailPage> createState() => _StaffDetailPageState();
}

class _StaffDetailPageState extends State<StaffDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as UserModel;

    void deleteStaff() async {
      var deleteStaff= await staffProvider.delete(args.id);

      var nav = Navigator.of(context);
      nav.pop();
      nav.pop();

      if (deleteStaff) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'Staff deleted successfully',
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
              'Failed to delete staff',
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
          'Detail Staff',
          style: primaryTextStyle.copyWith(fontSize: 18),
        ),
      );
    }

    Widget showImage() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Profile Image',
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: medium, color: primaryTextColor),
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    args.profileUrl,
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
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
              'Full Name',
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

    Widget usernameInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
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
                child: Text(args.username,
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .7))),
              ),
            )
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
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
                child: Text(args.email,
                    style: primaryTextStyle.copyWith(
                        color: Color.fromRGBO(255, 255, 255, .7))),
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
                Navigator.pushNamed(context, EditStaffPage.routeName,
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
                              "Confirmation Staff Deletion: Are you sure you want to delete this staff? This action cannot be reversed and the staff will permanently deleted from the system",
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
                                      deleteStaff();
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
            args.profileUrl != "" ? showImage() : const SizedBox(),
            nameInput(),
            usernameInput(),
            emailInput(),
          ],
        ),
      )),
    );
  }
}
