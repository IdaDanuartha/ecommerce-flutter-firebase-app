import 'package:ecommerce_firebase/models/user_model.dart';
import 'package:ecommerce_firebase/services/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late UserModel? _user;
  // List<UserModel> _staff = [];
  List<UserModel> _customers = [];
  List<UserModel> _admins = [];

  UserModel? get user => _user;
  // List<UserModel> get staff => _staff;
  List<UserModel> get customers => _customers;
  List<UserModel> get admins => _admins;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  // set staff(List<UserModel> staff) {
  //   _staff = staff;
  //   notifyListeners();
  // }

  set customers(List<UserModel> customers) {
    _customers = customers;
    notifyListeners();
  }

  set admins(List<UserModel> admins) {
    _admins = admins;
    notifyListeners();
  }

  Future<void> getUser(String id) async {
    try {
      UserModel? user = await UserService().getUser(id);
      _user = user;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
  
  Future<UserModel?> getUserById(String id) async {
    try {
      UserModel? user = await UserService().getUser(id);
      return user;
    } catch (e) {
      print(e);
    }
  }

  // Future<void> getStaff() async {
  //   try {
  //     List<UserModel> staff = await UserService().getStaff();
  //     _staff = staff;

  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> getCustomers() async {
    try {
      List<UserModel> customers = await UserService().getCustomers();
      _customers = customers;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAdmins() async {
    try {
      List<UserModel> admins = await UserService().getAdmins();
      _admins = admins;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> updateProfile(Map<Object, Object> data) async {
    try {
      var user = await UserService().updateProfile(data);

      _user = UserModel.fromJson(user);

      notifyListeners();
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}