import 'package:flutter/material.dart';
import 'package:hack_town_front/widgets/google_maps/tracking_google_map.dart';

import '../dtos/event_route.dart';

class RouteButtons extends StatelessWidget {

  const RouteButtons(this.selectedValue ,{super.key});

  final List<EventRouteDTO>? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDropdownItem(
            context,
            selectedValue?[0].name ?? "Show Ukraine Map",
            Icons.map,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GoogleMapsPage(selectedValue![0]),
                ),
              );
            },
          ),
          buildDropdownItem(
            context,
            selectedValue?[1].name ?? "Show Ukraine Map",
            Icons.map,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GoogleMapsPage(selectedValue![1]),
                ),
              );
            },
          ),
          buildDropdownItem(
            context,
            selectedValue?[2].name ?? "Show Ukraine Map",
            Icons.map,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GoogleMapsPage(selectedValue![2]),
                ),
              );
            },
          ),
          buildDropdownItem(
            context,
            selectedValue?[3].name ?? "Show Ukraine Map",
            Icons.map,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GoogleMapsPage(selectedValue![3]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDropdownItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(icon, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}