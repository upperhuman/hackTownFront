// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Region Page
class SettingsRegionPage extends StatelessWidget {
  const SettingsRegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
        ],
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