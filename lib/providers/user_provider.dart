import 'package:ecommerce_firebase/models/user_model.dart';
import 'package:ecommerce_firebase/services/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  List<UserProvider> _users = [];
  List<UserProvider> get users => _users;

  set users(List<UserProvider> users) {
    _users = users;
    notifyListeners();
  }

  Future<void> getUsers() async {
    try {
      List<UserModel> users = await UserService().getUsers();
      // _users = users;
    } catch (e) {
      print(e);
    }
  }
}