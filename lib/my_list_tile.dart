import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {

  final String imagepath;
  final String tileName;
  final String TileSubtile;
  final Function onDelete;
final String docId;


  const MyListTile({
    super.key,
    required this.TileSubtile,
    required this.imagepath,
    required this.tileName,
    required this.onDelete, required  this.docId });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:20.0),
        child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     
                      Container(
                        height: 80,
                        padding: EdgeInsets.all(12),
                        decoration:BoxDecoration(
                          color:Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          ),
                        child: Image.asset(imagepath),

                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tileName,
                          style: TextStyle(
                            fontWeight:FontWeight.bold,
                            fontSize: 20 ),),
                            SizedBox(height: 12,),
                          Text(TileSubtile,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),),
                        ],
                      ),
                        IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          onDelete(docId);
                        },
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  )
                  ,);
  }
}