import 'package:flutter/material.dart';

// Location Page
class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: const Align(
        child: LocationButtons()
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