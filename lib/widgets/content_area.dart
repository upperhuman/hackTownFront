import 'package:flutter/material.dart';

// Content Area on the Main PAge
class ContentArea extends StatelessWidget {
  const ContentArea({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}