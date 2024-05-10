import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  late String id;
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
    required this.price,
    required this.discount,
    required this.qty,
    required this.description,
    required this.createdAt,
    required this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    print(json["images"]);
    id = json["id"];
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