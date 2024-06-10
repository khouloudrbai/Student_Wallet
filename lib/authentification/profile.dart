import 'package:flutter/material.dart';
import 'package:student_wallet/Home.dart';

class ProfileScreen extends StatelessWidget {
  final String fullName;
  final String cardNumber;
  final String email;

  const ProfileScreen( {
    Key? key,
    required this.fullName,
    required this.cardNumber,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController(text: fullName);
    TextEditingController cardNumberController = TextEditingController(text: cardNumber);
    TextEditingController emailController = TextEditingController(text: email);

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
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  'https://img.freepik.com/vecteurs-premium/avatar-icon002_750950-52.jpg',
                ),
              ),
              SizedBox(height: 10),
              Text(
                fullName,
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
                        controller: cardNumberController,
                        decoration: InputDecoration(
                          labelText: 'Card Number:',
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
