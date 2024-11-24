import 'package:flutter/material.dart';

// User Profile page
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: const Align(
        child: UserProfileButtons()
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