import 'package:ecommerce_firebase/models/product_model.dart';

class CartModel {
  late String id;
  late String userId;
  late String name;
  late double price;
  late double discount;
  late int qty;
  late List<dynamic> images;
  late ProductModel product;

  CartModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.price,
    required this.discount,
    required this.qty,
    required this.images,
    required this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    name = json["name"];
    price = double.parse(json["price"].toString());
    discount = double.parse(json["discount"].toString());
    qty = int.parse(json["qty"].toString());
    images = json['images'];
    product = ProductModel.fromJson(json["product"]);
    // createdAt = DateTime.parse(json["created_at"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "name": name,
      "price": price,
      "discount": discount,
      "qty": qty,
      "images": images,
      "product": product.toJson(),
      // "created_at": createdAt.toString(),
    };
  }
}