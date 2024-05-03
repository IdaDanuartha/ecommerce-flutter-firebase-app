import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/models/user_model.dart';

class UserService {

  Future<List<UserModel>> getUsers() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<UserModel> usersModel = [];
    
    var users = await db.collection("users").get().then(
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