import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_firebase/models/product_model.dart';

class ProductService {
  String baseUrl = "http://192.168.0.124:8000/api";

  Future<List<ProductModel>> getProducts() async {
    var url = '$baseUrl/products';
    var headers = {
      "Content-Type": "application/json"
    };
    var response = await http.get(
      Uri.parse(url),
      headers: headers
    );

    // print(jsonDecode(response.body)["data"][0]["data"]);
    if(response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"][0]["data"];
      List<ProductModel> products = [];

      for(var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception("Failed to fetch products data");
    }
  }
}