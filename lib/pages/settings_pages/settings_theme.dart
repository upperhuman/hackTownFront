import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Theme Page
class SettingsThemePage extends StatelessWidget {
  const SettingsThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings_page.theme".tr()),
      ),
      body: const Align(
        child: ThemeButtons()
      )
    );
  }
}

// Buttons on the Theme page
class ThemeButtons extends StatelessWidget {
  const ThemeButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}