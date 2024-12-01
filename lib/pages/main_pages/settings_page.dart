import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../settings_pages/settings_language.dart';
import '../settings_pages/settings_region.dart';
import '../settings_pages/settings_theme.dart';
import '../settings_pages/settings_security.dart';
import '../settings_pages/settings_notifications.dart';
import '../settings_pages/settings_faq.dart';


// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/SettingsBackground.jpg', fit: BoxFit.cover),
          ),
          AppBar(
            title: Text("settings_page".tr()),
            elevation: 0,
          ),
          const Align(
            child: SettingsButtons(),
          )
        ],
      ),
    );
  }
}

// Buttons on the Settings page
class SettingsButtons extends StatelessWidget {
  const SettingsButtons({super.key});
  @override
  Widget build(BuildContext context) {
    
    final ButtonStyle buttonStyle = TextButton.styleFrom(
      //foregroundColor: Colors.black,
      textStyle: const TextStyle(
        fontSize: 30,
      )
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            TextButton(
              style: buttonStyle,
              child: Text("settings_page.language".tr()),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsLanguagePage()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              style: buttonStyle,
              child: Text("settings_page.region".tr()),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsRegionPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              style: buttonStyle,
              child: Text("settings_page.theme".tr()),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsThemePage()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              style: buttonStyle,
              child: Text("settings_page.security".tr()),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsSecurityPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              style: buttonStyle,
              child: Text("settings_page.notifications".tr()),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsNotificationsPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              style: buttonStyle,
              child: Text("settings_page.faq".tr()),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsFAQPage()),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}