import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_wallet/Home.dart';
import 'package:student_wallet/authentification/Signin.dart';
import 'package:student_wallet/authentification/profile.dart';
import 'package:student_wallet/authentification/signup.dart';
import 'package:student_wallet/mainpage.dart';
void main() async {
 WidgetsFlutterBinding.ensureInitialized();

  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: 'AIzaSyD93glAXbTfRlBDnQucJ2b6oAQD-_ULrrk',
      appId: '1:30554660382:android:113d9cb73d9307c775180f',
      messagingSenderId: '30554660382',
      projectId: 'studentloan-b389b',
      storageBucket: 'studentloan-b389b.appspot.com'
  );

  await Firebase.initializeApp(options: firebaseOptions);

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Student Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUp(), // Replace with your initial screen
    );
  }
  
}
