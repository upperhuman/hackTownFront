// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../widgets/positionated_buttons.dart';

// User Profile page
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PositionatedButtons(),
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