import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> getOrders() async {
    try {
      _orders.clear();
      List<OrderModel> orders = await OrderService().getOrders();
      _orders = orders;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getOrdersByUser({String? userId = ""}) async {
    try {
      _orders.clear();
      List<OrderModel> orders = await OrderService().getOrders();
      User? user = FirebaseAuth.instance.currentUser;

      var foundItem = orders.firstWhere((order) => order.userId == user!.uid,
          orElse: () => OrderModel(id: "", code: "", userId: "", subTotal: 0.0, totalDiscount: 0.0, deliveryFee: 0.0, status: 1, paymentMethod: "", createdAt: Timestamp.now(), items: []));
    
      if (foundItem.id != "") {
        _orders = orders;
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}