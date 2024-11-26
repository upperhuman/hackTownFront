import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Region Page
class SettingsRegionPage extends StatelessWidget {
  const SettingsRegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings_page.region".tr()),
      ),
      body: const Align(
        child: RegionButtons()
      )
    );
  }
}

// Buttons on the Region page
class RegionButtons extends StatelessWidget {
  const RegionButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}