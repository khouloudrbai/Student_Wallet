import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:student_wallet/authentification/profile.dart';
import 'package:student_wallet/my_button.dart';
import 'package:student_wallet/my_list_tile.dart';
import 'package:student_wallet/wallet.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String salary = "";

  List<Widget> _myListTiles = [];
    List<Widget> Listtiles = [];

  List<Widget> ButtonsList = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }



  void _loadUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          setState(() {
            salary = userDoc.get('salary').toString();
            List<dynamic> tiles = userDoc.get('tiles');

            _myListTiles = tiles.map((tile) {
              return MyListTile(
                TileSubtile: tile['tileSubtile'],
                imagepath: 'images/statics.jpg', // Update the image if necessary
                tileName: tile['tileName'],
                docId: '', // The document ID is not used in this context
                 onDelete: (docId) {
                // Remove the tile from Firestore and the UI
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .collection('tiles')
                    .doc(docId)
                    .delete();
                setState(() {
                  _myListTiles.removeWhere((tile) => tile is MyListTile && tile.docId == docId);
                });
              },
              );
            }).toList();
          });
        }
      } catch (e) {
        print("Error loading user data: $e");
      }
    }
  }


  void navigateToProfile(BuildContext context) async {
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

  final _controller = PageController();

  void _addNewListTile(BuildContext context) async {
    String tileSubtile = '';
    String tileName = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New List Section'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Section Name'),
                onChanged: (value) => tileSubtile = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Tile Name'),
                onChanged: (value) => tileName = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                User? user = _auth.currentUser;
                if (user != null) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection('tiles')
                      .add({
                    'tileSubtile': tileSubtile,
                    'tileName': tileName,
                  });

                  setState(() {
                    _myListTiles.add(
                      MyListTile(
                        TileSubtile: tileSubtile,
                        imagepath: 'images/statics.jpg',
                        tileName: tileName,
                        docId: '', // Will not be used as we are not setting it here
                        onDelete: (docId) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .collection('tiles')
                              .where('tileSubtile', isEqualTo: tileSubtile)
                              .where('tileName', isEqualTo: tileName)
                              .get()
                              .then((snapshot) {
                            snapshot.docs.first.reference.delete();
                          });
                          setState(() {
                            _myListTiles.removeWhere((tile) => tile is MyListTile && tile.TileSubtile == tileSubtile && tile.tileName == tileName);
                          });
                        },
                      ),
                    );
                  });
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Wallet',
                          style: TextStyle(fontSize: 28),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _addNewListTile(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                height: 200,
                child: PageView(
                  controller: _controller,
                  children: [
                    MyWallet(
                      name: 'current situation',
                      salary: salary,
                      Date: DateTime.now(),
                      color: Colors.deepPurple[300],
                    ),
                    MyWallet(
                      name: 'loans',
                      salary: salary,
                      Date: DateTime.now(),
                      color: Colors.blue[300],
                    ),
                    MyWallet(
                      name: 'Borrowed money',
                      salary: salary,
                      Date: DateTime.now(),
                      color: Colors.green[300],
                    )
                  ],
                ),
              ),
              SizedBox(height: 25),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                  children: [
                    MyButton(butttonText: 'grocery shopping', iconImage: 'images/groceries.png'),
                    SizedBox(width: 10,),
                    MyButton(butttonText: 'Savings', iconImage: 'images/payment.jpg'),
                    SizedBox(width: 10,),

                    MyButton(butttonText: 'loans', iconImage: 'images/payment.jpg'),
                    SizedBox(width: 10,),

                    MyButton(butttonText: 'Borrowed Money', iconImage: 'images/payment.jpg'),
                    SizedBox(width: 10,),

                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _addNewListTile(context);
                        },
                      ),
                    ),
                  ],
                ),),),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: _myListTiles,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
