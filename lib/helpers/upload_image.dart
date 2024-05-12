import 'package:firebase_storage/firebase_storage.dart';

List<String> uploadMultipleImages(images) {
  List<String> imageUrls = [];
  images.forEach((element) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      var date = DateTime.now().millisecondsSinceEpoch;
      try {
        UploadTask task = storage
            .ref('products/${date}_image.png')
            .putData(await element.readAsBytes(),
                SettableMetadata(contentType: 'image/jpeg'));

        TaskSnapshot downloadUrl = (await task);

        String url = (await downloadUrl.ref.getDownloadURL());
        
        imageUrls.add(url);
        print(imageUrls);
      } on FirebaseException catch (e) {
        throw Exception(e.message);
      }
    });

    return imageUrls;
}