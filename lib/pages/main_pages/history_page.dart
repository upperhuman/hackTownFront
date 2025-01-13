// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hack_town_front/widgets/positionated_buttons.dart';

// History Page
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

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

// Buttons on the History Page
class HistoryButtons extends StatelessWidget {
  const HistoryButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}