import 'package:easy_localization/easy_localization.dart';
import '../../widgets/positionated_buttons.dart';
import '../settings_pages/settings_notifications.dart';
import '../settings_pages/language.dart/settings_language.dart';
import '../settings_pages/settings_security.dart';
import '../settings_pages/settings_region.dart';
import '../settings_pages/settings_theme.dart';
import '../settings_pages/settings_faq.dart';
import 'package:flutter/material.dart';


// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PositionatedButtons(),
          const Center(
            child: SettingsButtons(), // Вставляем кнопки в центр
          ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Центровка по вертикали
      children: [
        TextButton(
          child: Text(
            "settings_page.language".tr(),
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 30,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsLanguagePage()),
            );
          },
        ),
        const SizedBox(height: 20),
        TextButton(
          child: Text(
            "settings_page.region".tr(),
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 30,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsRegionPage()),
            );
          },
        ),
        const SizedBox(height: 20),
        TextButton(
          child: Text(
            "settings_page.theme".tr(),
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 30,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsThemePage()),
            );
          },
        ),
        const SizedBox(height: 20),
        TextButton(
          child: Text(
            "settings_page.security".tr(),
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 30,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsSecurityPage()),
            );
          },
        ),
        const SizedBox(height: 20),
        TextButton(
          child: Text(
            "settings_page.notifications".tr(),
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 30,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsNotificationsPage()),
            );
          },
        ),
        const SizedBox(height: 20),
        TextButton(
          child: Text(
            "settings_page.faq".tr(),
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 30,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsFAQPage()),
            );
          },
        ),
      ],
    );
  }
}
