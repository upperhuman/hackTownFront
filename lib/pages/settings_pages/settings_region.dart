import 'package:flutter/material.dart';

// Region Page
class SettingsRegionPage extends StatelessWidget {
  const SettingsRegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Region'),
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