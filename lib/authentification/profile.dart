import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_wallet/Home.dart';

class ProfileScreen extends StatefulWidget {
  final String fullName;
  final String salary;
  final String email;

  ProfileScreen({
    required this.fullName,
    required this.salary,
    required this.email,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
      // Handle the error, for example, by showing a dialog or a snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController(text: widget.fullName);
    TextEditingController salaryController = TextEditingController(text: widget.salary);
    TextEditingController emailController = TextEditingController(text: widget.email);

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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      fullName: widget.fullName,
                      salary: widget.salary,
                      email: widget.email,
                    ),
                  ));
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
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: _image == null
                        ? NetworkImage('https://media.istockphoto.com/id/1300845620/fr/vectoriel/appartement-dic%C3%B4ne-dutilisateur-isol%C3%A9-sur-le-fond-blanc-symbole-utilisateur.jpg?s=612x612&w=0&k=20&c=BVOfS7mmvy2lnfBPghkN__k8OMsg7Nlykpgjn0YOHj0=')
                        : FileImage(_image!) as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo_rounded),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.fullName,
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 25,
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
                          labelText: 'salary:',
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


