import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/models/product_model.dart';

class ProductService {

  Future<List<ProductModel>> getProducts() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<ProductModel> productsModel = [];
    
    var products = await db.collection("products").get().then(
      (querySnapshot) {


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
}