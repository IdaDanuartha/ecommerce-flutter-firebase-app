import 'package:MushMagic/models/product_model.dart';
import 'package:MushMagic/services/product_service.dart';
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

  Future<bool> update(String productId, Map<Object, Object> data) async {
    try {
      var product = await ProductService().update(productId, data);
      int index = _products.indexWhere((item) => item.id == productId);
      _products[index] = ProductModel.fromJson(product);

      notifyListeners();
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> delete(String productId) async {
    try {
      await ProductService().delete(productId);
      int index = _products.indexWhere((item) => item.id == productId);
      _products.removeAt(index);

      notifyListeners();
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}