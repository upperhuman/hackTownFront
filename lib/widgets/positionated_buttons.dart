import 'package:flutter/material.dart';

class PositionatedButtons extends StatelessWidget{
  const PositionatedButtons({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 45,
            ),
          ),
          // User profile button
          /*Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(Icons.account_circle_outlined, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const UserProfilePage()),
                );
              },
              iconSize: 45,
            ),
          ),*/
        ],
      ),
    );
  }
}