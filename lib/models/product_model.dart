import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  late String id;
  late String productId;
  late String name;
  late double price;
  late double discount;
  late int qty;
  late String description;
  late Timestamp createdAt;
  late List<dynamic> images;

  ProductModel({
    required this.id,
    required this.name,
    required this.productId,
    required this.price,
    required this.discount,
    required this.qty,
    required this.description,
    required this.createdAt,
    required this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    name = json["name"];
    price = double.parse(json["price"].toString());
    discount = double.parse(json["discount"].toString());
    qty = int.parse(json["qty"].toString());
    description = json["description"];
    images = json['images'];
    createdAt = json["created_at"] is String ? Timestamp.now() : json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "product_id": productId,
      "name": name,
      "price": price,
      "discount": discount,
      "qty": qty,
      "description": description,
      "images": images,
      "created_at": createdAt.toString(),
    };
  }
}