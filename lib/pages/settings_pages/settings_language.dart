import 'package:flutter/material.dart';
import 'package:hack_town_front/widgets/language_picker.dart';
// import 'package:easy_localization/easy_localization.dart';

class SettingsLanguagePage extends StatelessWidget {
  const SettingsLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/SettingsBackground2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 45,
            ),
          ),
          const Align(
            child: LanguageButtons(),
          ),
        ],
      ),
    );
  }
}
