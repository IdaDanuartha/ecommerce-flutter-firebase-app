// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:MushMagic/controllers/add_single_image_controller.dart';
import 'package:MushMagic/helpers/upload_image.dart';
import 'package:MushMagic/providers/staff_provider.dart';
import 'package:MushMagic/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:MushMagic/themes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddStaffPage extends StatefulWidget {
  const AddStaffPage({Key? key}) : super(key: key);

  static const routeName = '/staff/add';

  @override
  State<AddStaffPage> createState() => _AddStaffPageState();
}

class _AddStaffPageState extends State<AddStaffPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AddSingleImageController addSingleImageController =
      Get.put(AddSingleImageController());

  @override
  void initState() {
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);

    XFile? selectedImage = addSingleImageController.selectedImage.value;

    void storeStaff() async {
      showDialog(context: context, builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });

      var nav = Navigator.of(context);

      // if (selectedImage != null) {
        // An image is selected, proceed with uploading
        // Future<String> profileUrl = uploadSingleImage(selectedImage, "users");

        // profileUrl.then((url) async {
          var newStaff = await staffProvider.store({
            "name": _nameController.text,
            "username": _usernameController.text,
            "email": _emailController.text,
            "profile_url": "",
            "role": "staff",
            "password": _passwordController.text
          }, context);

          if (newStaff) {
            nav.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: successColor,
                duration: const Duration(milliseconds: 2500),
                content: const Text(
                  'Staff created successfully',
                  textAlign: TextAlign.center,
                ),
              ),
            );

            addSingleImageController.selectedImage.value = null;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: alertColor,
                duration: const Duration(milliseconds: 2500),
                content: const Text(
                  'Failed to create staff',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        // }).catchError((error) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       backgroundColor: alertColor,
        //       duration: const Duration(milliseconds: 2500),
        //       content: const Text(
        //         'Error when uploading profile image',
        //         textAlign: TextAlign.center,
        //       ),
        //     ),
        //   );
        // });
      // } else {
      //   // No image is selected
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         backgroundColor: alertColor,
      //         duration: const Duration(milliseconds: 2500),
      //         content: const Text(
      //           'No image selected',
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //     );
      // }

      nav.pop();
    }

    Widget imageInput() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              addSingleImageController.showImagePickerDialog(context);
            },
            child: const Text("Select Profile Image"),
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
          'Add Staff',
          style: primaryTextStyle.copyWith(fontSize: 18),
        ),
      );
    }

    Widget showImage() {
      return //show Images
          GetBuilder<AddSingleImageController>(
        init: AddSingleImageController(),
        builder: (imageController) {
          return imageController.selectedImage.value != null
              ? Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: GridView.builder(
                    itemCount: 1,
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
                            File(imageController.selectedImage.value!.path),
                            fit: BoxFit.cover,
                            height: 100,
                            width: 120,
                          ),
                          Positioned(
                            right: 24,
                            top: -3,
                            child: InkWell(
                              onTap: () {
                                imageController.removeImage();
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
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _nameController,
                      style: secondaryTextStyle,
                      decoration: InputDecoration(
                          hintText: 'Input full name',
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
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _usernameController,
                      style: secondaryTextStyle,
                      decoration: InputDecoration(
                          hintText: 'Input username',
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
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _emailController,
                      style: secondaryTextStyle,
                      decoration: InputDecoration(
                          hintText: 'Input email',
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

    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
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
                      controller: _passwordController,
                      obscureText: true,
                      style: secondaryTextStyle,
                      decoration: InputDecoration(
                          hintText: 'Input password',
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

    Widget addButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: storeStaff,
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
            // imageInput(),
            showImage(),
            nameInput(),
            usernameInput(),
            emailInput(),
            passwordInput(),
            isLoading ? const LoadingButton(text: "Creating", marginTop: 20) : addButton(),
          ],
        ),
      )),
    );
  }
}
