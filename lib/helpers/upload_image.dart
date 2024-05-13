import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<String> uploadSingleImage(XFile? image, String name) async {
  if (image != null) {
    String? imageUrl;

    FirebaseStorage storage = FirebaseStorage.instance;
    var date = DateTime.now().millisecondsSinceEpoch;
    try {
      // Access the XFile object from Rx<XFile?> and then call readAsBytes() on it
      List<int> imageData = await image.readAsBytes();

      UploadTask task = storage.ref('$name/${date}_image.png').putData(
          Uint8List.fromList(imageData), SettableMetadata(contentType: 'image/jpeg'));

      TaskSnapshot downloadUrl = await task;

      String url = await downloadUrl.ref.getDownloadURL();

      imageUrl = url;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }

    return imageUrl;
  } 

  return "";
  // throw Exception('No image selected');
}


List<String> uploadMultipleImages(images) {
  List<String> imageUrls = [];

  try {
      images.forEach((element) async {
        FirebaseStorage storage = FirebaseStorage.instance;
        var date = DateTime.now().millisecondsSinceEpoch;

        UploadTask task = storage.ref('products/${date}_image.png').putData(
          await element.readAsBytes(),
            SettableMetadata(contentType: 'image/jpeg'));

        TaskSnapshot downloadUrl = (await task);

        String url = (await downloadUrl.ref.getDownloadURL());

        imageUrls.add(url);
      });
      print(imageUrls);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }

  return imageUrls;
}