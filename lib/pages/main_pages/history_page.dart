// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// History Page
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

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

// Buttons on the History Page
class HistoryButtons extends StatelessWidget {
  const HistoryButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}