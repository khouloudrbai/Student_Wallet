

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_wallet/authentification/UserModel.dart';

class AuthService{
  FirebaseAuth _auth=FirebaseAuth.instance;



  Future<User?> Signup (String email,String password) async {

    try{
     UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);

         return userCredential.user;
    }catch(e){
      print('error de signup'); 
    }
    return null;   

  }


  Future<User?> Signip (String email,String password) async {

    try{
     UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: email, password: password);

         return userCredential.user;
    }catch(e){
      print('error de signup'); 
    }
    return null;   

  }


  Future<UserModel?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection("users").doc(userId).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return null;
  }
  
}