import 'package:ecommerce_firebase/models/product_model.dart';
import 'package:ecommerce_firebase/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> store(newData) async {
    try {
      var product = await ProductService().store(newData);
      _products.add(ProductModel.fromJson(product));

      notifyListeners();
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}