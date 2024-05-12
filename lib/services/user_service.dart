import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/models/user_model.dart';

class UserService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<UserModel?> getUser(String id) async { 
    UserModel? userModel;

    await db.collection("users").doc(id).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;

        userModel = UserModel.fromJson(data);
      },
      onError: (e) => print("Error completing: $e"),
    );

    return userModel;
  }

  Future<List<UserModel>> getStaff() async {
    List<UserModel> usersModel = [];
    
    await db.collection("users").where("role", isEqualTo: "staff").get().then(
      (querySnapshot) {
        for(var item in querySnapshot.docs) {
          Map<String, dynamic> data = item.data();
          data['id'] = item.id;

          usersModel.add(UserModel.fromJson(data));
        }
        
      },
      onError: (e) => print("Error completing: $e"),
    );

    return usersModel;
  }

  Future<List<UserModel>> getCustomers() async {
    List<UserModel> usersModel = [];
    
    await db.collection("users").where("role", isEqualTo: "customer").get().then(
      (querySnapshot) {
        for(var item in querySnapshot.docs) {
          Map<String, dynamic> data = item.data();
          data['id'] = item.id;

          usersModel.add(UserModel.fromJson(data));
        }
        
      },
      onError: (e) => print("Error completing: $e"),
    );

    return usersModel;
  }

    Future<List<UserModel>> getAdmins() async {
    List<UserModel> usersModel = [];
    
    await db.collection("users").where("role", isEqualTo: "admin").get().then(
      (querySnapshot) {
        for(var item in querySnapshot.docs) {
          Map<String, dynamic> data = item.data();
          data['id'] = item.id;

          usersModel.add(UserModel.fromJson(data));
        }
        
      },
      onError: (e) => print("Error completing: $e"),
    );

    return usersModel;
  }
}