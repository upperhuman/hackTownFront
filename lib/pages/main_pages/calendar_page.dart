// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hack_town_front/widgets/positionated_buttons.dart';

// Calendar Page
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

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

// Buttons on the Calendar Page
class CalendarButtons extends StatelessWidget {
  const CalendarButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}