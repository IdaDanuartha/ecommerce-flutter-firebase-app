// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ecommerce_firebase/controllers/add_single_image_controller.dart';
import 'package:ecommerce_firebase/helpers/upload_image.dart';
import 'package:ecommerce_firebase/models/user_model.dart';
import 'package:ecommerce_firebase/providers/staff_provider.dart';
import 'package:ecommerce_firebase/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditStaffPage extends StatefulWidget {
  const EditStaffPage({Key? key}) : super(key: key);

  static const routeName = '/staff/edit';

  @override
  State<EditStaffPage> createState() => _EditStaffPageState();
}

class _EditStaffPageState extends State<EditStaffPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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

    final args = ModalRoute.of(context)!.settings.arguments as UserModel;

    _nameController.text = args.name;
    _usernameController.text = args.username;
    _emailController.text = args.email;

    void updateStaff() async {
      setState(() {
        isLoading = true;
      });
      // print("YOOO : ${addSingleImageController.selectedImage.value}");
      Future<String> profileUrl = uploadSingleImage(selectedImage, "users");

        profileUrl.then((url) async {
          var updateStaff = await staffProvider.update(args.id, {
            "name": _nameController.text,
            "email": _emailController.text,
            "username": _usernameController.text,
            "profile_url": url == "" ? args.profileUrl : url,
          });

          var nav = Navigator.of(context);
          nav.pop();
          nav.pop();

          if (updateStaff) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: successColor,
                duration: const Duration(milliseconds: 2500),
                content: const Text(
                  'Staff updated successfully',
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
                  'Failed to update staff',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: successColor,
              duration: const Duration(milliseconds: 2500),
              content: const Text(
                'Error when uploading profile image',
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
      
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
          'Edit Staff',
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

    Widget oldImages() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Old Images',
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
                      readOnly: true,
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

    Widget updateButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: updateStaff,
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
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        child: Column(
          children: [
            imageInput(),
            oldImages(),
            addSingleImageController.selectedImage.value != null
                ? Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'New Profile Image',
                        style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                            color: primaryTextColor),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            showImage(),
            nameInput(),
            usernameInput(),
            emailInput(),
            isLoading ? LoadingButton(text: "Saving", marginTop: 20) : updateButton(),
          ],
        ),
      )),
    );
  }
}
