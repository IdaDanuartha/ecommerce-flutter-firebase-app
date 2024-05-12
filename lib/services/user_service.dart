import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<dynamic> updateProfile(Map<Object, Object> data) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    User? user = FirebaseAuth.instance.currentUser;
    // String email = data["email"].toString();
    // bool checkEmail = email == user!.email;

    DocumentReference userRef = db.collection("users").doc(user!.uid);
    await userRef.update(data);
    
    // if(checkEmail) {
    //   await user.verifyBeforeUpdateEmail(email);
    //   await user.sendEmailVerification();
    // }
    
    // Use the user ID to fetch the document data
    DocumentSnapshot userSnapshot = await userRef.get();

    // Check if the document exists and retrieve the data
    if (userSnapshot.exists) {
      Map<String, dynamic> user = userSnapshot.data() as Map<String, dynamic>;
      user['id'] = userRef.id;
      return user;
    } else {
      print("User document does not exist");
      return null;
    }
  }
}