import 'package:flutter/material.dart';

// Notifications Page
class SettingsNotificationsPage extends StatelessWidget {
  const SettingsNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: const Align(
        child: NotificationsButtons()
      )
    );
  }
}

// Buttons on the Notifications page
class NotificationsButtons extends StatelessWidget {
  const NotificationsButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}
