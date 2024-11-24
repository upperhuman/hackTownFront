import 'package:flutter/material.dart';

// Calendar Page
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: const Align(
        child: CalendarButtons()
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