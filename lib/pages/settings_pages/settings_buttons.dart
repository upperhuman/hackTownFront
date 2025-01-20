import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'language.dart/settings_language.dart';
import 'settings_faq.dart';
import 'settings_notifications.dart';
import 'settings_region.dart';
import 'settings_security.dart';
import 'settings_theme.dart';

class SettingsButtons extends StatelessWidget {
  const SettingsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent, // Убирает фон
            foregroundColor: Theme.of(context).textTheme.bodyLarge?.color, // Цвет текста
          ),
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
              MaterialPageRoute(builder: (context) => LanguagePage()),
            );
          },
        ),
        const SizedBox(height: 20),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent, // Убирает фон
            foregroundColor: Theme.of(context).textTheme.bodyLarge?.color, // Цвет текста
          ),
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
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent, // Убирает фон
            foregroundColor: Theme.of(context).textTheme.bodyLarge?.color, // Цвет текста
          ),
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
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent, // Убирает фон
            foregroundColor: Theme.of(context).textTheme.bodyLarge?.color, // Цвет текста
          ),
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
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent, // Убирает фон
            foregroundColor: Theme.of(context).textTheme.bodyLarge?.color, // Цвет текста
          ),
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
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent, // Убирает фон
            foregroundColor: Theme.of(context).textTheme.bodyLarge?.color, // Цвет текста
          ),
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