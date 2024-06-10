import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? fullName;
  String? cardNumber;

  UserModel({this.uid, this.email, this.fullName, this.cardNumber});

  // Receiving data from server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      cardNumber: map['cardNumber'],
    );
  }

  // Sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'cardNumber': cardNumber,
    };
  }

  // Function to fetch user data from Firestore
  Future<UserModel?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection("users").doc(userId).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return null;
  }
}
