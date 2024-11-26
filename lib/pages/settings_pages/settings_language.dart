import 'package:flutter/material.dart';
import 'package:hack_town_front/widgets/language_picker.dart'; // Новый файл с кнопками выбора языка
import 'package:easy_localization/easy_localization.dart';

class SettingsLanguagePage extends StatelessWidget {
  const SettingsLanguagePage({Key? key}) : super(key: key);

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
          AppBar(
            title: Text("settings_page.language".tr()),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          const Align(
            child: LanguageButtons(),
          ),
        ],
      ),
    );
  }
}
