import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_wallet/Home.dart';
import 'package:student_wallet/authentification/profile.dart';

class MoneyDetails extends StatelessWidget {
  const MoneyDetails({super.key});


void navigateToProfile(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        String fullName = userDoc.get('fullName');
        String salary = userDoc.get('salary');
        String userEmail = userDoc.get('email');

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
              fullName: fullName,
              salary: salary,
              email: userEmail,
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "User data not found!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController( );
    TextEditingController salaryController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                },
                icon: Icon(
                  Icons.home,
                  size: 28,
                ),
              ),
              IconButton(
                onPressed: () {
                   navigateToProfile(context);
                },
                icon: Icon(
                  Icons.account_box,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'My',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Wallet',
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
             
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: salaryController,
                        decoration: InputDecoration(
                          labelText: 'Budget:',
                        ),
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email:',
                        ),
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Password:',
                          hintText: '**********',
                        ),
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                        obscureText: true,
                      ),
                       SizedBox(height: 10),
                     MaterialButton(
                        onPressed: () {
                        },
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Update Profile",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        textColor: Colors.white,
                        color: Colors.deepPurpleAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }  
}