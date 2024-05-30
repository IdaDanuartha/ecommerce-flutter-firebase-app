import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MushMagic/models/address_model.dart';
import 'package:MushMagic/models/order_item_model.dart';

class OrderModel {
  late String id;
  late String code;
  late String customerName;
  late String phone;
  late String userId;
  late double subTotal;
  late double totalDiscount;
  late double deliveryFee;
  late int status;
  late String paymentMethod;
  late Timestamp createdAt;
  late List<OrderItemModel> items;
  late AddressModel address;

  OrderModel({
    required this.id,
    required this.code,
    required this.customerName,
    required this.phone,
    required this.userId,
    required this.subTotal,
    required this.totalDiscount,
    required this.deliveryFee,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
    required this.items,
    required this.address,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    customerName = json["customer_name"];
    phone = json["phone"];
    userId = json["user_id"];
    subTotal = double.parse(json["sub_total"].toString());
    totalDiscount = double.parse(json["total_discount"].toString());
    deliveryFee = double.parse(json["delivery_fee"].toString());
    status = json["status"];
    paymentMethod = json["payment_method"];
    createdAt = json["created_at"];
    address = AddressModel.fromJson(json["address"]);

    List<dynamic> itemDataList = json['items'];
    items = itemDataList.map((itemData) => OrderItemModel.fromJson(itemData)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "code": code,
      "customer_name": customerName,
      "phone": phone,
      "user_id": userId,
      "sub_total": subTotal,
      "total_discount": totalDiscount,
      "delivery_fee": deliveryFee,
      "status": status,
      "payment_method": paymentMethod,
      "created_at": createdAt.toString(),
      "items": items.map((item) => item.toJson()).toList(),
      "address": address.toJson(),
    };
  }
}