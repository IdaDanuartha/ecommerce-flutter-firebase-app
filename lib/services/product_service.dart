import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/models/product_model.dart';

class ProductService {

  Future<List<ProductModel>> getProducts() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<ProductModel> productsModel = [];
    
    var products = db.collection("products").snapshots().listen(
      (querySnapshot) {

        productsModel.clear();
        for(var item in querySnapshot.docs) {
          Map<String, dynamic> data = item.data();
          data['id'] = item.id;

          productsModel.add(ProductModel.fromJson(data));
        }
        
      },
      onError: (e) => print("Error completing: $e"),
    );

    return productsModel;
  }

  Future store(newData) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection("products").add(newData).then(
      (value) => print("Document successfully created!"),
      onError: (e) => print("Error creating document $e")
    );
  }
}