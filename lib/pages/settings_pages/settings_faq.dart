// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// FAQ Page
class SettingsFAQPage extends StatelessWidget {
  const SettingsFAQPage({super.key});

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