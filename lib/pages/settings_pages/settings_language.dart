import 'package:flutter/material.dart';

// Language Page
class SettingsLanguagePage extends StatelessWidget{
  const SettingsLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
      ),
      body: const Align(
        child: LanguageButtons()
      ),
    );
  }
}

// Buttons on the Language page
class LanguageButtons extends StatelessWidget {
  const LanguageButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}