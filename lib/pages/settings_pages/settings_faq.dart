import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// FAQ Page
class SettingsFAQPage extends StatelessWidget {
  const SettingsFAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings_page.faq".tr()),
      ),
      body: const Align(
        child: FAQButtons()
      )
    );
  }
}

// Buttons on the FAQ page
class FAQButtons extends StatelessWidget {
  const FAQButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}