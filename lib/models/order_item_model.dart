import 'package:MushMagic/models/product_model.dart';

class OrderItemModel {
  late ProductModel product;
  late double price;
  late double discount;
  late int qty;

  OrderItemModel({
    required this.product,
    required this.price,
    required this.discount,
    required this.qty,
  });

  OrderItemModel.fromJson(Map<String, dynamic> json) {
    product = ProductModel.fromJson(json['product']); 
    price = double.parse(json["price"].toString());
    discount = double.parse(json["discount"].toString());
    qty = int.parse(json["qty"].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "product": product.toJson(),
      "price": price,
      "discount": discount,
      "qty": qty,
    };
  }
}