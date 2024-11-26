import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Notifications Page
class SettingsNotificationsPage extends StatelessWidget {
  const SettingsNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings_page.notifications".tr()),
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
