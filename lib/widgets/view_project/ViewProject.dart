import 'package:flutter/material.dart';

class SideDrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dashboard"),
            SizedBox(height: 10),
            Text("About"),
            SizedBox(height: 10),
            Text("Expenses"),
            SizedBox(height: 10),
            Text("Tasks"),
            SizedBox(height: 10),
            Text("Collaborators"),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

Widget dashboard(context){
  return Material(
    elevation: 8,
    color: Color(0xFFEBEBEB),
    child: Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(child: Icon(Icons.menu, color: Color(0xFF333333), 
                ),
                
                
              ),

          ],)
        ],

    ),),

  );
}