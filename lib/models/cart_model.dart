import 'package:ecommerce_firebase/models/product_model.dart';

class CartModel {
  late String id;
  late String userId;
  late int qty;
  late ProductModel product;

  CartModel({
    required this.id,
    required this.userId,
    required this.qty,
    required this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    qty = int.parse(json["qty"].toString());
    product = ProductModel.fromJson(json["product"]);
    // createdAt = DateTime.parse(json["created_at"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "qty": qty,
      "product": product.toJson(),
      // "created_at": createdAt.toString(),
    };
  }
}