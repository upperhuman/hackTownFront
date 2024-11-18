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
            title: const Text('Settings'),
            backgroundColor: Colors.transparent,
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
      foregroundColor: Colors.black,
      textStyle: const TextStyle(
        fontFamily: 'InknutAntiqua',
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
              child: const Text('Language'),
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
              child: const Text('Region'),
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
              child: const Text('Theme'),
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
              child: const Text('Security'),
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
              child: const Text('Notification'),
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
              child: const Text('FAQ'),
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