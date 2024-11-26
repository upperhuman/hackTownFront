import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Route page
class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("route_page".tr()),
      ),
      body: const Align(
        child: RouteButtons()
      )
    );
  }
}

// Buttons on the Route Page
class RouteButtons extends StatelessWidget {
  const RouteButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}