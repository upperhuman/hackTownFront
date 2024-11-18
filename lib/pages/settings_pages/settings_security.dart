import 'package:flutter/material.dart';

// Security Page
class SettingsSecurityPage extends StatelessWidget {
  const SettingsSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security'),
      ),
      body: const Align(
        child: SecurityButtons()
      )
    );
  }
}

// Buttons on the Security page
class SecurityButtons extends StatelessWidget {
  const SecurityButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}