import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:MushMagic/themes.dart';
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
                  Text("Pick an image!",
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 18)),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ]),
            insetPadding: const EdgeInsets.all(10),
            content: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      selectImages("camera");
                      Navigator.pop(context);
                    },
                    child: const Text('Camera'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      selectImages("gallery");
                      Navigator.pop(context);
                    },
                    child: const Text('Gallery'),
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
