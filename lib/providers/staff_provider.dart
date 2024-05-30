import 'package:MushMagic/models/user_model.dart';
import 'package:MushMagic/services/staff_service.dart';
import 'package:flutter/material.dart';

class StaffProvider with ChangeNotifier {
  List<UserModel> _staff = [];
  List<UserModel> get staff => _staff;

  set staff(List<UserModel> staff) {
    _staff = staff;
    notifyListeners();
  }

  Future<void> getStaff() async {
    try {
      List<UserModel> stf = await StaffService().getStaff();
      _staff = stf;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> store(staffData, BuildContext context) async {
    try {
      var stf = await StaffService().store(staffData, context);
      _staff.add(UserModel.fromJson(stf));

      notifyListeners();
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> update(String stfId, Map<Object, Object> data) async {
    try {
      var stf = await StaffService().update(stfId, data);
      int index = _staff.indexWhere((item) => item.id == stfId);
      _staff[index] = UserModel.fromJson(stf);

      notifyListeners();
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> delete(String staffId) async {
    try {
      await StaffService().delete(staffId);
      int index = _staff.indexWhere((item) => item.id == staffId);
      _staff.removeAt(index);

      notifyListeners();
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}