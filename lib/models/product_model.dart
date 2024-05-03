import 'dart:ffi';

class ProductModel {
  late int id;
  late String name;
  late double price;
  late double discount;
  late String description;
  // late DateTime createdAt;
  // late DateTime updatedAt;
  late List<Array> images;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.description,
    // required this.createdAt,
    // required this.updatedAt,
    required this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    price = double.parse(json["price"].toString());
    discount = double.parse(json["discount"].toString());
    description = json["description"];
    images = json['images'];
    // createdAt = DateTime.parse(json["updated_at"]);
    // updatedAt = DateTime.parse(json["created_at"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "discount": discount,
      "description": description,
      "images": images,
      // "created_at": createdAt.toString(),
      // "updated_at": updatedAt.toString(),
    };
  }
}