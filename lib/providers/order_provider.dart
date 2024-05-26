import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/models/order_model.dart';
import 'package:ecommerce_firebase/providers/cart_provider.dart';
import 'package:ecommerce_firebase/providers/product_provider.dart';
import 'package:ecommerce_firebase/services/order_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];
  List<OrderModel> _tempOrders = [];
  List<OrderModel> get orders => _orders;
  List<OrderModel> get tempOrders => _tempOrders;

  List<double> _ordersMonthly = [];
  List<double> get ordersMonthly => _ordersMonthly;

  set orders(List<OrderModel> orders) {
    _orders = orders;
    notifyListeners();
  }

  set tempOrders(List<OrderModel> tempOrders) {
    _tempOrders = tempOrders;
    notifyListeners();
  }

  set ordersMonthly(List<double> ordersMonthly) {
    _ordersMonthly = ordersMonthly;
    notifyListeners();
  }

  // Method to filter orders by Date
  List<OrderModel> filterOrdersByDate(Timestamp startDate, Timestamp endDate) {
    _orders = _tempOrders;
    var orderFiltered = _orders.where((order) {
      return order.createdAt.compareTo(startDate) >= 0 && order.createdAt.compareTo(endDate) <= 0;
    }).toList();

    _orders = orderFiltered;
    notifyListeners();
    
    return orderFiltered;
  }

  Future<void> getOrders() async {
    try {
      _orders.clear();
      List<OrderModel> orders = await OrderService().getOrders();
      _orders = orders;
      _tempOrders = orders;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getOrdersMonthly() async {
    try {
      _ordersMonthly.clear();
      for(int i = 1; i <= 12; i++) {
        double ordersCount = await OrderService().getOrdersMonthly(i);
        _ordersMonthly.add(ordersCount);
      }

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

  Future<bool> cancelOrder(String orderId, Map<Object, Object> data, BuildContext context) async {
    try {
      ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);

      var order = await OrderService().cancelOrder(orderId, data);
      int index = _orders.indexWhere((item) => item.id == orderId);

      // await Future.forEach(order.items, (item) async {
      //   await productProvider.update(item., {
      //     "qty": item.product.qty + item.qty
      //   });
      // });

      if(index != -1) {
        _orders[index] = OrderModel.fromJson(order);
      }

      await productProvider.getProducts();

      notifyListeners();
      return true;
    } catch (e) {
      print("Error Provider: $e");
      return false;
    }
  }

  Future<bool> changeStatusOrder(String orderId, Map<Object, Object> data, BuildContext context) async {
    try {
      ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);

      var order = await OrderService().changeStatusOrder(orderId, data);
      int index = _orders.indexWhere((item) => item.id == orderId);

      // await Future.forEach(order.items, (item) async {
      //   await productProvider.update(item., {
      //     "qty": item.product.qty + item.qty
      //   });
      // });

      if(index != -1) {
        _orders[index] = OrderModel.fromJson(order);
      }

      await productProvider.getProducts();

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