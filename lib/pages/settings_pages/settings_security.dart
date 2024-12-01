import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Security Page
class SettingsSecurityPage extends StatelessWidget {
  const SettingsSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings_page.security".tr()),
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