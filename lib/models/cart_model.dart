class CartModel {
  late String id;
  late String userId;
  late String name;
  late double price;
  late double discount;
  late int qty;
  late List<String> images;

  CartModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.price,
    required this.discount,
    required this.qty,
    // required this.createdAt,
    required this.images,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    name = json["name"];
    price = double.parse(json["price"].toString());
    discount = double.parse(json["discount"].toString());
    qty = int.parse(json["qty"].toString());
    images = json['images'];
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
      // "created_at": createdAt.toString(),
    };
  }
}