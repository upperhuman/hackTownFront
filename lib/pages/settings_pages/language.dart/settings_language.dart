import 'package:flutter/material.dart';
import 'package:hack_town_front/main.dart';
import 'package:hack_town_front/pages/settings_pages/language.dart/language_picker.dart';
import 'package:hack_town_front/widgets/positionated_buttons.dart';
// import 'package:easy_localization/easy_localization.dart';

class SettingsLanguagePage extends StatelessWidget {
  const SettingsLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ThemedImageWidget(),
            ),
          PositionatedButtons(),
          const Align(
            child: LanguageButtons(),
          ),
        ],
      ),
    );
  }
}
