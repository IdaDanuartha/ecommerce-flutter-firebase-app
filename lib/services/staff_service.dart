import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StaffService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<UserModel> staffModel = [];

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

  Future<dynamic> store(staffData, userData) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    // print(userData["email"]);

    var userCredential = await auth.createUserWithEmailAndPassword(
      email: userData["email"],
      password: userData["password"],
    );

    // Access the User object from UserCredential
    var user = userCredential.user;

    // Get the user ID
    String userId = user!.uid;
    
    DocumentReference staffRef = await db.collection("users").doc(userId);
    staffRef.set(staffData);

    // Use the staff ID to fetch the document data
    DocumentSnapshot staffSnapshot = await staffRef.get();

    // Check if the document exists and retrieve the data
    if (staffSnapshot.exists) {
      Map<String, dynamic> staff =
          staffSnapshot.data() as Map<String, dynamic>;
      staff['id'] = staffRef.id;
      // staffModel.add(UserModel.fromJson(staff));
      return staff;
    } else {
      print("Staff document does not exist");
      return null;
    }
  }
 
  Future<dynamic> update(String staffId, Map<Object, Object> data) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference staffRef = db.collection("users").doc(staffId);
    await staffRef.update(data);
    
    // Use the staff ID to fetch the document data
    DocumentSnapshot staffSnapshot = await staffRef.get();

    // Check if the document exists and retrieve the data
    if (staffSnapshot.exists) {
      Map<String, dynamic> staff = staffSnapshot.data() as Map<String, dynamic>;
      staff['id'] = staffRef.id;
      return staff;
    } else {
      print("Staff document does not exist");
      return null;
    }
  }

  Future<dynamic> delete(String staffId) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference staffRef = db.collection("users").doc(staffId);
    await staffRef.delete();
    
    // Use the staff ID to fetch the document data
    DocumentSnapshot staffSnapshot = await staffRef.get();

    // Check if the document exists and retrieve the data
    if (staffSnapshot.exists) {
      Map<String, dynamic> staff = staffSnapshot.data() as Map<String, dynamic>;
      staff['id'] = staffRef.id;
      return staff;
    } else {
      print("Staff document does not exist");
      return null;
    }
  }
}
