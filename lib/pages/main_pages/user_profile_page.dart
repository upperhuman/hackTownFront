// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// User Profile page
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

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
        ],
      )
    );
  }
}

// Buttons on the User Profile Page
class UserProfileButtons extends StatelessWidget {
  const UserProfileButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}