import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:student_wallet/authentification/profile.dart';
import 'package:student_wallet/my_button.dart';
import 'package:student_wallet/my_list_tile.dart';
import 'package:student_wallet/wallet.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller =PageController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: BottomAppBar(
      child:Padding(
        padding: EdgeInsets.only(top: 8.0),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          IconButton(
            onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));

            },
          icon: Icon(
            Icons.home,
            size: 28,),),
          IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));

          },icon: Icon(
            Icons.account_box,
            size: 28,),)

        ],),),
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
                  Row(children: [
                 Text(
                    'My',
                    style: TextStyle(
                      fontSize:28,
                      fontWeight: FontWeight.bold),
                  ),
                  Text('Wallet',
                  style: TextStyle(
                    fontSize:28,
                  ),
                  )

                  ],),

                    Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape:BoxShape.circle,
                ),
                child: Icon(Icons.add),
              )
                 
                ],
              ),
              
             
          ),
          SizedBox(height: 25,),
           Container(
            height: 200,
            child: PageView(children: [
              MyWallet(
                name: 'current situation',
                credit: 500.00,
                card: 15284,
                Date: DateTime.now(),
                color: Colors.deepPurple[300],
              ),
              MyWallet(
                name:'loans',
                credit: 500.00,
                card: 15284,
                Date: DateTime.now(),
                color: Colors.blue[300],
              ),
              MyWallet(
                name:'Borrowed money',
                credit: 500.00,
                card: 15284,
                Date: DateTime.now(),
                color: Colors.green[300],
              )
            ],),
           ),

           SizedBox(height:25),

            SmoothPageIndicator(
              controller: _controller,
               count: 3,
               effect: ExpandingDotsEffect(
                activeDotColor: Colors.grey.shade800,
               ),),

               SizedBox(height: 25,),
              Padding(
                padding: const  EdgeInsets.symmetric(horizontal:25.0)  ,
                child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          
                   MyButton(butttonText:'payment' ,iconImage:'images/payment.jpg' ,),
                   MyButton(butttonText:'payment' ,iconImage:'images/payment.jpg' ,),
                   MyButton(butttonText:'payment' ,iconImage:'images/payment.jpg' ,),

                ],
               ),),
               SizedBox(height: 25,),
               Padding(
                 padding:const EdgeInsets.symmetric(horizontal:25.0),
                 child:Column(
                 children: [
                 
                   MyListTile(TileSubtile: 'payment income', imagepath: 'images/statics.jpg', tileName: 'statics subtile'),
                    MyListTile(TileSubtile: 'payment income', imagepath: 'images/statics.jpg', tileName: 'statics subtile'),
                   MyListTile(TileSubtile: 'payment income', imagepath: 'images/statics.jpg', tileName: 'statics subtile'),

                 ],),
                )
          ],
        
          ),),
    )   
    );

  }
}