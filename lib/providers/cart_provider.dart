import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/models/cart_model.dart';
import 'package:ecommerce_firebase/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _items = [];

  List<CartModel> get items => _items;

  double get totalPrice {
    return _items.fold(
        0, (total, current) => total + (current.product.price * current.qty));
  }

    double get totalDiscount {
    return _items.fold(
        0, (total, current) => total + (current.product.discount * current.qty));
  }

  void addItem(CartModel item) {
    var foundItem = _items.firstWhere((i) => i.id == item.id,
        orElse: () => CartModel(
          id: "", 
          userId: "", 
          qty: 0, 
          product: ProductModel(
            id: "",
            name: '',
            price: 0.0,
            discount: 0.0,
            qty: 0,
            images: [],
            description: '',
            createdAt: Timestamp.now()
          )
        ));

    if (foundItem.id != "") {
      foundItem.qty += 1;
    } else {
      _items.add(item);
    }

    saveItemsToPrefs();
    notifyListeners();
  }

  void increaseQty(CartModel item) {
    if(item.qty < item.product.qty) {
      item.qty += 1;
    }
    
    saveItemsToPrefs();
    notifyListeners();
  }

  void decreaseQty(CartModel item) {
    item.qty -= 1;
    if (item.qty <= 0) {
      _items.remove(item);
    }

    saveItemsToPrefs();
    notifyListeners();
  }

  void removeItem(CartModel item) {
    _items.remove(item);

    saveItemsToPrefs();
    notifyListeners();
  }

  Future<void> saveItemsToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      _items.map((item) {
        return item.toJson();
      }).toList(),
    );
    await prefs.setString('cartItems', encodedData);
  }

  Future<void> loadItemsFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemsString = prefs.getString('cartItems');

    User? user = FirebaseAuth.instance.currentUser;
    
    if (itemsString != null) {
      final List<dynamic> jsonData = json.decode(itemsString) as List<dynamic>;
      final Iterable<dynamic> getItemsByUser = jsonData.where((data) => data["user_id"] == user!.uid);

      _items = getItemsByUser
          .map((item) => CartModel.fromJson(item as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  // Call this method to clear all items in cart
  Future<void> clearCart() async {
    _items = [];
    await saveItemsToPrefs();
    notifyListeners();
  }
}