import 'dart:io';

import 'package:MushMagic/controllers/add_single_image_controller.dart';
import 'package:MushMagic/helpers/upload_image.dart';
import 'package:MushMagic/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:MushMagic/themes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  static const routeName = '/profile/edit';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController(text: '');
  TextEditingController _usernameController = TextEditingController(text: '');
  TextEditingController _emailController = TextEditingController(text: '');

  AddSingleImageController addSingleImageController =
      Get.put(AddSingleImageController());

  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of<UserProvider>(context);
    XFile? selectedImage = addSingleImageController.selectedImage.value;
  
    var user = userProvider.user!;
    _nameController.text = user.name;
    _usernameController.text = user.username;
    _emailController.text = user.email;

    void updateProfile() async {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });

    try {
      String profileUrl = await uploadSingleImage(selectedImage, "users");
      
      var updateProfile = await userProvider.updateProfile({
          "name": _nameController.text,
          "username": _usernameController.text,
          "email": _emailController.text,
          "profile_url": profileUrl.isEmpty ? user.profileUrl : profileUrl
        });

        if (updateProfile) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: successColor,
              duration: const Duration(milliseconds: 2500),
              content: const Text(
                'Profile updated successfully',
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
                'Failed to update profile',
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
              'Error when uploading profile image',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

    addSingleImageController.selectedImage.value = null;

      // profileUrl.then((url) async { 

      //   var updateProfile = await userProvider.updateProfile({
      //     "name": _nameController.text,
      //     "username": _usernameController.text,
      //     "email": _emailController.text,
      //     "profile_url": url == "" ? user.profileUrl : url
      //   });

      //   if (updateProfile) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         backgroundColor: successColor,
      //         duration: const Duration(milliseconds: 2500),
      //         content: const Text(
      //           'Profile updated successfully',
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //     );
      //   } else {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         backgroundColor: alertColor,
      //         duration: const Duration(milliseconds: 2500),
      //         content: const Text(
      //           'Failed to update profile',
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //     );
      //   }
      // }).catchError((error) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       backgroundColor: successColor,
      //       duration: const Duration(milliseconds: 2500),
      //       content: const Text(
      //         'Error when uploading profile image',
      //         textAlign: TextAlign.center,
      //       ),
      //     ),
      //   );
      // });

      Navigator.of(context).pop();
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
        backgroundColor: bgColor1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: primaryTextStyle.copyWith(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: primaryColor,
            ),
            onPressed: updateProfile,
          ),
        ],
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            TextFormField(
              controller: _nameController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                  hintText: 'Enter your name',
                  hintStyle: secondaryTextStyle,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: subtitleColor))),
            )
          ],
        ),
      );
    }

    Widget usernameInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            TextFormField(
              controller: _usernameController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                  hintText: 'Enter your username',
                  hintStyle: secondaryTextStyle,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: subtitleColor))),
            )
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            TextFormField(
              controller: _emailController,
              style: primaryTextStyle,
              readOnly: true,
              decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: secondaryTextStyle,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: subtitleColor))),
            )
          ],
        ),
      );
    }

    Widget showImage() {
      return //show Images
          GetBuilder<AddSingleImageController>(
        init: AddSingleImageController(),
        builder: (imageController) {
          return imageController.selectedImage.value != null
              ? InkWell(
                  onTap: () {
                    addSingleImageController.showImagePickerDialog(context);
                  },
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: defaultMargin),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(File(imageController
                                    .selectedImage.value!.path)))),
                      ),
                      Positioned(
                          top: 68,
                          left: 35,
                          child: Icon(
                            Icons.camera_alt,
                            size: 32,
                            color: Colors.black.withOpacity(0.7),
                          )),
                    ],
                  ),
                )
              : const SizedBox.shrink();
        },
      );
    }

    Widget profileImage() {
      return InkWell(
        onTap: () {
          addSingleImageController.showImagePickerDialog(context);
        },
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: defaultMargin),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(user.profileUrl != ""
                          ? user.profileUrl
                          : "https://firebasestorage.googleapis.com/v0/b/ecommerce-flutter-22e70.appspot.com/o/users%2Fuser.png?alt=media&token=f8257f26-5525-4216-8cac-99c9184b7467"))),
            ),
            Positioned(
                top: 68,
                left: 35,
                child: Icon(
                  Icons.camera_alt,
                  size: 32,
                  color: Colors.black.withOpacity(0.7),
                )),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<AddSingleImageController>(
              init: AddSingleImageController(),
              builder: (imageController) {
                return imageController.selectedImage.value != null
                    ? showImage()
                    : profileImage();
              },
            ),
            nameInput(),
            usernameInput(),
            emailInput(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: header(),
      body: content(),
      resizeToAvoidBottomInset: false,
    );
  }
}
