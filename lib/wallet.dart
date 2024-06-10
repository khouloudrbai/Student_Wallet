import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyWallet extends StatelessWidget {

  final double credit;
  final int card;
  final DateTime Date;
  final color;
  final String name;

  const MyWallet({
  Key?key,

  required this.credit,
  required this.card,
 required this.Date,
  required this.color,
  required this.name,
  }):super(key: key);
  




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 20),
      child:Container(
            width: 300,
            padding: EdgeInsets.all(20),
            decoration:BoxDecoration(color: color,
            
           borderRadius: BorderRadius.circular(20),
             
            ),
          
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, 
                  children:[    
                      Image.asset('images/visa.png',height: 35,),
                ]),

                Text(name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25),),
                  SizedBox(height:5),
                Text(
                '\$'+credit.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //card number
                    Text(
                      card.toString(),
                    style: TextStyle(
                      color: Colors.white, 
                    ),),
                    //date
                    Text(
                      Date.toString(),
                    style: TextStyle(
                      color: Colors.white, )),
                  ],
                )
              ]),),);
  
  }
}