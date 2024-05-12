// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously
import 'package:ecommerce_firebase/models/user_model.dart';
import 'package:ecommerce_firebase/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:provider/provider.dart';

class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({Key? key}) : super(key: key);

  static const routeName = '/customer/detail';

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as UserModel;

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
          'Detail User',
          style: primaryTextStyle.copyWith(fontSize: 18),
        ),
      );
    }

    // Widget showImages() {
    //   return Container(
    //     margin: const EdgeInsets.only(top: 20),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Align(
    //           alignment: Alignment.centerLeft,
    //           child: Text(
    //             'Product Images',
    //             style: primaryTextStyle.copyWith(
    //                 fontSize: 16, fontWeight: medium, color: primaryTextColor),
    //           ),
    //         ),
    //         const SizedBox(height: 12),
    //         Wrap(
    //           spacing: 10,
    //           runSpacing: 20,
    //           children: [
    //             for(var image in args.images ) ClipRRect(
    //               borderRadius: BorderRadius.circular(4),
    //               child: Image.network(
    //                   image,
    //                 width: 110,
    //                 height: 110,
    //                 fit: BoxFit.cover,
    //               ),
    //             )
    //           ]
    //         )
    //       ],
    //     ),
    //   );
    // }

    Widget nameInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
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

    return Scaffold(
      appBar: header(),
      backgroundColor: bgColor1,
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        child: Column(
          children: [
            // showImages(),
            nameInput(),
            usernameInput(),
            emailInput(),
          ],
        ),
      )),
    );
  }
}
