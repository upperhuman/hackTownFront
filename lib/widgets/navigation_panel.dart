import 'package:flutter/material.dart';
import '/pages/main_pages/location_page.dart';
import '/pages/main_pages/route_page.dart';
import '/pages/main_pages/calendar_page.dart';
import '/pages/main_pages/history_page.dart';
import '/pages/main_pages/settings_page.dart';

// Navigation Panel on the Main Page
class NavigationPanel extends StatelessWidget {
  const NavigationPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      color: Colors.grey[350],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.location_on_outlined, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LocationPage()),
                  );
                },
                iconSize: 45,
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: const Icon(Icons.route_outlined, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RoutePage()),
                  );
                },
                iconSize: 45,
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: const Icon(Icons.calendar_month_outlined, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CalendarPage()),
                  );
                },
                iconSize: 45,
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: const Icon(Icons.history_outlined, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryPage()),
                  );
                },
                iconSize: 45,
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            iconSize: 45,
          ),
        ],
      ),
    );
  }
}