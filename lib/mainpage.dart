import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 2,
        backgroundColor: Colors.white,
        title:const Text('Dashboard',style: TextStyle(color: Colors.black),
        ),
        actions:<Widget>[
          Container(
            margin:const EdgeInsets.only(right: 8.0),
             child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  <Widget>[
                Icon(Icons.arrow_drop_down, color: Colors.black54)
              ],
             ),
          )
        ],),
     body: StaggeredGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        children:  <Widget>[
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Total Views', style: TextStyle(color: Colors.blueAccent)),
                      Text('265K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
                    ],
                  ),
                  Material(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24.0),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.timeline, color: Colors.white, size: 30.0),
                      )
                    )
                  )
                ]
              ),
            ),
          ),
          _buildTile(
            const Padding(
              padding:  EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  <Widget>[
                  Material(
                    color: Colors.teal,
                    shape: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.settings_applications, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('General', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                  Text('Images, Videos', style: TextStyle(color: Colors.black45)),
                ]
              ),
            ),
          ),
          _buildTile(
           const  Padding(
              padding:  EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  <Widget>[
                  Material(
                    color: Colors.amber,
                    shape: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.notifications, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('Alerts', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                  Text('All ', style: TextStyle(color: Colors.black45)),
                ]
              ),
            ),
          ),
  
          _buildTile(
           const  Padding(
              padding:  EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  <Widget>[
                  Material(
                    color: Colors.red,
                    shape: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.store, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('Shop Items', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                  Text('All ', style: TextStyle(color: Colors.black45)),
                ]
              ),
            ),
            
          )
        ],
     
      ),
    );

  }

  Widget _buildTile(Widget child, {VoidCallback? onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: const Color(0x802196F3),
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}