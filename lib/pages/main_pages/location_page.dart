import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Location Page
class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("location_page".tr()),
      ),
      body: const Align(
        child: LocationButtons()
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