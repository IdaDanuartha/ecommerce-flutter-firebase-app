import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddSingleImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> selectedImage;
  final Rx<String> imageUrl = ''.obs;
  final FirebaseStorage storageRef = FirebaseStorage.instance;

  AddSingleImageController() : selectedImage = Rx<XFile?>(null);

  Future<void> showImagePickerDialog(BuildContext context) async {
    PermissionStatus status;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;

    if (androidDeviceInfo.version.sdkInt <= 32) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.mediaLibrary.request();
    }

    if (status == PermissionStatus.granted) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            backgroundColor: bgColor3,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pick an image!", style: primaryTextStyle),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: primaryTextColor,
                  ),
                ),
              ],
            ),
            insetPadding: EdgeInsets.all(10),
            content: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      selectImage("camera");
                      Navigator.pop(context);
                    },
                    child: Text('Camera'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      selectImage("gallery");
                      Navigator.pop(context);
                    },
                    child: Text('Gallery'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    if (status == PermissionStatus.denied) {
      print("Error: Please allow permission for further usage");
      openAppSettings();
    }
    if (status == PermissionStatus.permanentlyDenied) {
      print("Error: Please allow permission for further usage");
      openAppSettings();
    }
  }

  void removeImage() {
    selectedImage.value = null;
    update();
  }

  Future<void> selectImage(String type) async {
    XFile? img;
    if (type == 'gallery') {
      try {
        img = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
        update();
      } catch (e) {
        print('Error: $e');
      }
    } else {
      try {
        img = await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
        update();
      } catch (e) {
        print('Error: $e');
      }
    }


    if (img != null) {
      selectedImage.value = img;
      update();
      print("PATH : ${selectedImage.value?.path}");
    }
  }

  Future<void> uploadImage() async {
    if (selectedImage.value != null) {
      imageUrl.value = await uploadFile(selectedImage.value!);
      update();
    }
  }

  Future<String> uploadFile(XFile image) async {
    TaskSnapshot reference = await storageRef
        .ref()
        .child("product-images")
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(File(image.path));

    return await reference.ref.getDownloadURL();
  }
}
