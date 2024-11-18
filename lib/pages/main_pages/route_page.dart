import 'package:flutter/material.dart';

// Route page
class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route'),
      ),
      body: const Align(
        child: RouteButtons()
      )
    );
  }
}

// Buttons on the Route Page
class RouteButtons extends StatelessWidget {
  const RouteButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}