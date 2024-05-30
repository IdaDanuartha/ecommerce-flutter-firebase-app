import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MushMagic/models/product_model.dart';

class ProductService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<ProductModel> productsModel = [];

  Future<List<ProductModel>> getProducts() async {
    var products = await db.collection("products").orderBy("created_at").get().then(
      (querySnapshot) {
        productsModel.clear();
        for (var item in querySnapshot.docs) {
          Map<String, dynamic> data = item.data();
          data['id'] = item.id;

          productsModel.add(ProductModel.fromJson(data));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    return productsModel;
  }

  Future<dynamic> store(newData) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference productRef = await db.collection("products").add(newData);

    // Use the product ID to fetch the document data
    DocumentSnapshot productSnapshot = await productRef.get();

    // Check if the document exists and retrieve the data
    if (productSnapshot.exists) {
      Map<String, dynamic> product =
          productSnapshot.data() as Map<String, dynamic>;
      product['id'] = productRef.id;
      // productsModel.add(ProductModel.fromJson(product));
      return product;
    } else {
      print("Product document does not exist");
      return null;
    }
  }
 
  Future<dynamic> update(String productId, Map<Object, Object> data) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference productRef = db.collection("products").doc(productId);
    await productRef.update(data);
    
    // Use the product ID to fetch the document data
    DocumentSnapshot productSnapshot = await productRef.get();

    // Check if the document exists and retrieve the data
    if (productSnapshot.exists) {
      Map<String, dynamic> product = productSnapshot.data() as Map<String, dynamic>;
      product['id'] = productRef.id;
      return product;
    } else {
      print("Product document does not exist");
      return null;
    }
  }

  Future<dynamic> delete(String productId) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference productRef = db.collection("products").doc(productId);
    await productRef.delete();
    
    // Use the product ID to fetch the document data
    DocumentSnapshot productSnapshot = await productRef.get();

    // Check if the document exists and retrieve the data
    if (productSnapshot.exists) {
      Map<String, dynamic> product = productSnapshot.data() as Map<String, dynamic>;
      product['id'] = productRef.id;
      return product;
    } else {
      print("Product document does not exist");
      return null;
    }
  }
}
