// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Location Page
class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

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

// Buttons on the Location Page
class LocationButtons extends StatelessWidget {
  const LocationButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}