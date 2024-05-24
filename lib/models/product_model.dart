import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/models/promotion_model.dart';

class ProductModel {
  late String id;
  late PromotionModel promotion;
  late String name;
  late int price;
  late int discount;
  late int qty;
  late String description;
  late Timestamp createdAt;
  late List<dynamic> images;

  ProductModel({
    required this.id,
    required this.name,
    required this.promotion,
    required this.price,
    required this.discount,
    required this.qty,
    required this.description,
    required this.createdAt,
    required this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    promotion = PromotionModel.fromJson(json["promotion"]);
    name = json["name"];
    price = int.parse(json["price"].toString());
    discount = int.parse(json["discount"].toString());
    qty = int.parse(json["qty"].toString());
    description = json["description"];
    images = json['images'];
    createdAt = json["created_at"] is String ? Timestamp.now() : json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "promotion": promotion.toJson(),
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