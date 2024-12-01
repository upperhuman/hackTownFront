import 'package:hack_town_front/widgets/route_buttons.dart';
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDropdownItem("route_page.cinema".tr(), Icons.movie),
          buildDropdownItem("route_page.restaurant".tr(), Icons.restaurant),
          buildDropdownItem("route_page.shop".tr(), Icons.shopping_cart),
          buildDropdownItem("route_page.parking".tr(), Icons.local_parking),
        ],
      ),
    );
  }
}
