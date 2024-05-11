import 'package:ecommerce_firebase/models/order_model.dart';
import 'package:ecommerce_firebase/providers/cart_provider.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:ecommerce_firebase/services/order_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  Future<void> getOrdersByUser({String? userId}) async {
    try {
      _orders.clear();
      List<OrderModel> orders = await OrderService().getOrders();
      User? user = FirebaseAuth.instance.currentUser;

      var getOrdersByUser = orders.where((order) => order.userId == user!.uid);
    
      if (getOrdersByUser.isNotEmpty) {
        for (var order in getOrdersByUser) {
          _orders.add(order);
        }
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> cancelOrder(String orderId, Map<Object, Object> data) async {
    try {
      var order = await OrderService().cancelOrder(orderId, data);
      int index = _orders.indexWhere((item) => item.id == orderId);
      
      if(index != -1) {
        _orders[index] = OrderModel.fromJson(order);
      }

      notifyListeners();
      return true;
    } catch (e) {
      print("Error Provider: $e");
      return false;
    }
  }

  Future<bool> checkout(newData, BuildContext context) async {
    try {
      ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);
      CartProvider cartProvider= Provider.of<CartProvider>(context, listen: false);

      var order = await OrderService().checkout(newData);
      _orders.add(OrderModel.fromJson(order));
      
      await Future.forEach(cartProvider.items, (cart) async {
        await productProvider.update(cart.product.id, {
          "qty": cart.product.qty - cart.qty
        });
      });

      await cartProvider.clearCart();
      await productProvider.getProducts();
      await getOrders();

      notifyListeners();
      return true;
    } catch (e) {
      print("Error on provider: $e");
      return false;
    }
  }
}