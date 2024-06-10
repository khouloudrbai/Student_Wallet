import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String iconImage;
  final String butttonText;
  const MyButton({
    required this.butttonText,
    required this.iconImage,
    super.key});

  @override
  Widget build(BuildContext context) {
    return       Column(
                    children: [
                       Container(
                    height:90,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      //color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(
                        color:Colors.white,
                        blurRadius: 10,
                        spreadRadius: 10
                         )]
                      ), 
                    child: Center(
                       child: Image.asset(iconImage),
                    
                    ),
                  ),
                  SizedBox(height: 12,),
                  Text(butttonText,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),)
                    ],
                  );
  }
}