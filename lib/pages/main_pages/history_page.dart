import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// History Page
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("history_page".tr()),
      ),
      body: const Align(
        child: HistoryButtons()
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