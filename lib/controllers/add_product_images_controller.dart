import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProductImagesController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  RxList<XFile> selectedImages = <XFile>[].obs;
  final RxList<String> arrImagesUrl = <String>[].obs;
  final FirebaseStorage storageRef = FirebaseStorage.instance;

  Future<void> showImagesPickerDialog(BuildContext context) async {
    PermissionStatus status;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;

    if (androidDeviceInfo.version.sdkInt <= 32) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.mediaLibrary.request();
    }

    print(status);

    if (status == PermissionStatus.granted) {
      // Get.defaultDialog(
      //   title: "Choose Image",
      //   middleText: "Pick an image from the camera or gallery?",
      //   actions: [
      //     ElevatedButton(
      //       onPressed: () {
      //         Get.back();
      //         selectImages("camera");
      //       },
      //       child: Text('Camera'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         Get.back();
      //         selectImages("gallery");
      //       },
      //       child: Text('Gallery'),
      //     ),
      //   ],
      // );
      // AlertDialog(
      //     title: Text("Choose Image"),
      //     content: Text("Pick an image from the camera or gallery?"),
      //     actions: [
      //       ElevatedButton(
      //         onPressed: () {
      //           // Navigator.of(context).pop();
      //           selectImages("camera");
      //         },
      //         child: Text('Camera'),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           // Navigator.of(context).pop();
      //           selectImages("gallery");
      //         },
      //         child: Text('Gallery'),
      //       ),
      //     ],
      //   );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            backgroundColor: bgColor1,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Test",
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
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      selectImages("camera");
                    },
                    child: Text('Camera'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      selectImages("gallery");
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
      print("Error please allow permission for further usage");
      openAppSettings();
    }
    if (status == PermissionStatus.permanentlyDenied) {
      print("Error please allow permission for further usage");
      openAppSettings();
    }
  }

  Future<void> selectImages(String type) async {
    List<XFile> imgs = [];
    if (type == 'gallery') {
      try {
        imgs = await _picker.pickMultiImage(imageQuality: 80);
        update();
      } catch (e) {
        print('Error $e');
      }
    } else {
      final img =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

      if (img != null) {
        imgs.add(img);
        update();
      }
    }

    if (imgs.isNotEmpty) {
      selectedImages.addAll(imgs);
      update();
      print(selectedImages.length);
    }
  }

  void removeImages(int index) {
    selectedImages.removeAt(index);
    update();
  }

  //
  Future<void> uploadFunction(List<XFile> _images) async {
    arrImagesUrl.clear();
    for (int i = 0; i < _images.length; i++) {
      dynamic imageUrl = await uploadFile(_images[i]);
      arrImagesUrl.add(imageUrl.toString());
    }
    update();
  }

  //
  Future<String> uploadFile(XFile _image) async {
    TaskSnapshot reference = await storageRef
        .ref()
        .child("product-images")
        .child(_image.name + DateTime.now().toString())
        .putFile(File(_image.path));

    return await reference.ref.getDownloadURL();
  }
}
