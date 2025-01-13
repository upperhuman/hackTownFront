// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../widgets/positionated_buttons.dart';

// Location Page
class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

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

// Buttons on the Location Page
class LocationButtons extends StatelessWidget {
  const LocationButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}