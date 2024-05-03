
import 'package:firebase_storage/firebase_storage.dart';

class getDownloadURL {
  String? downloadURL;

  Future getUrl(String path) async {
    try {
      await downloadURLExample(path);
      return downloadURL;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> downloadURLExample(String path) async {
    downloadURL = await FirebaseStorage.instance
          .ref()
          .child(path)
          .getDownloadURL();   
  }
}