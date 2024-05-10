import 'package:ecommerce_firebase/models/user_model.dart';
import 'package:ecommerce_firebase/services/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> _staff = [];
  List<UserModel> _customers = [];
  List<UserModel> _admins = [];

  List<UserModel> get users => _users;
  List<UserModel> get staff => _staff;
  List<UserModel> get customers => _customers;
  List<UserModel> get admins => _admins;

  set users(List<UserModel> users) {
    _users = users;
    notifyListeners();
  }

  set staff(List<UserModel> staff) {
    _staff = staff;
    notifyListeners();
  }

  set customers(List<UserModel> customers) {
    _customers = customers;
    notifyListeners();
  }

  set admins(List<UserModel> admins) {
    _admins = admins;
    notifyListeners();
  }

  Future<void> getUsers() async {
    try {
      List<UserModel> users = await UserService().getUsers();
      _users = users;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getStaff() async {
    try {
      List<UserModel> staff = await UserService().getStaff();
      _staff = staff;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

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
}