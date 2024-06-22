import 'package:MushMagic/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MushMagic/models/user_model.dart';
import 'package:MushMagic/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaffService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

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

  Future<dynamic> store(staffData, BuildContext context) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    // print(userData["email"]);

    var userCredential = await auth.createUserWithEmailAndPassword(
      email: staffData["email"],
      password: staffData["password"],
    ).catchError((error) {
      if(error.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'The email address is already in use by another user',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    });

    await auth.signInWithEmailAndPassword(
      email: userProvider.user!.email,
      password: userProvider.user!.password,
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
