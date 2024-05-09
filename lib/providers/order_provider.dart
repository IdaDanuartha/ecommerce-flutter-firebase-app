import 'package:ecommerce_firebase/models/order_model.dart';
import 'package:ecommerce_firebase/services/order_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  set orders(List<OrderModel> orders) {
    _orders = orders;
    notifyListeners();
  }

  Future<void> getOrders({String? userId = ""}) async {
    try {
      List<OrderModel> orders = await OrderService().getOrders();
      User? user = FirebaseAuth.instance.currentUser;

      // if (userId != "") {
      //   final Iterable<dynamic> getOrdersByUser = orders.where((order) => order.userId == user!.uid);

      //   _orders = getOrdersByUser
      //       .map((item) => OrderModel.fromJson(item))
      //       .toList();
      // } else {
        _orders = orders;
      // }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}