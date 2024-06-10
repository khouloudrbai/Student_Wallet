import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_wallet/Home.dart';
import 'package:student_wallet/authentification/Signin.dart';
import 'package:student_wallet/authentification/UserModel.dart';
import 'package:student_wallet/authentification/authservice.dart';
import 'package:student_wallet/authentification/profile.dart';

Color primary = Color(0xff072227);
Color secondary = Color(0xff35858B);
Color primaryLight = Color(0xff4FBDBA);
Color secondaryLight = Color(0xffAEFEFF);

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController verifpassword = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late AuthService authService;

  @override
  void dispose() {
    fullName.dispose();
    cardNumber.dispose();
    email.dispose();
    password.dispose();
    verifpassword.dispose();
    super.dispose();  // Call super.dispose()
  }

  @override
  void initState() {
    super.initState();
    authService = AuthService();  // Initialize the class variable
  }

  @override
  Widget build(BuildContext context) {
    final FirstnameField = TextFormField(
      autocorrect: false,
      controller: fullName,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("fullName cannot be empty");
        } else if (!regex.hasMatch(value)) {
          return ("fullName must be longer than 3 characters");
        }
        return null;
      },
      onSaved: (value) {
        fullName.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "fullName ",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final LastnameField = TextFormField(
      autocorrect: false,
      controller: cardNumber,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Lastname cannot be empty");
        } else if (!regex.hasMatch(value)) {
          return ("Lastname must be longer than 3 characters");
        }
        return null;
      },
      onSaved: (value) {
        cardNumber.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: " cardNumber",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: email,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ('Please enter your email');
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        email.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: password,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Create a password to signup.");
        }
        if (!regex.hasMatch(value)) {
          return ("Password must be at least 6 characters long");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: verifpassword,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please confirm your password");
        }
        if (verifpassword.text != password.text) {
          return ("Passwords do not match");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final RegisterButton = Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(30),
      color: primary,
      child: MaterialButton(
        onPressed: () {
          signUp(email.text, password.text);
        },
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        textColor: Colors.white,
        child: const Text(
          "Sign up",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          color: primary,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FirstnameField,
                    SizedBox(height: 15),
                    LastnameField,
                    SizedBox(height: 15),
                    emailField,
                    SizedBox(height: 15),
                    passwordField,
                    SizedBox(height: 15),
                    confirmPasswordField,
                    SizedBox(height: 15),
                    RegisterButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

void signUp(String email, String password) async {
  if (_formKey.currentState!.validate()) {
    User? user = await authService.Signup(email, password);
    if (user != null) {
      await postDetailsToFirestore();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    } else {
      Fluttertoast.showToast(msg: "Sign Up Failed. Please try again.");
    }
  }
}

postDetailsToFirestore() async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = _auth.currentUser;

  if (user != null) {
    UserModel userModel = UserModel(
      uid: user.uid,
      email: user.email,
      fullName: fullName.text,
      cardNumber: cardNumber.text,
    );

    try {
      await firebaseFirestore.collection("users").doc(user.uid).set(userModel.toMap());
      Fluttertoast.showToast(msg: "Account Created Successfully :)");
    } catch (e) {
      print("Error saving user data: $e");
      Fluttertoast.showToast(msg: "Error creating account. Please try again.");
    }
  }
}

  
}