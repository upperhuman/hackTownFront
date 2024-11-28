import 'package:flutter/material.dart';
import '/pages/main_pages/location_page.dart';
import '/pages/main_pages/route_page.dart';
import '/pages/main_pages/calendar_page.dart';
import '/pages/main_pages/history_page.dart';

class BottomNavigationPanel extends StatelessWidget {
  const BottomNavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BottomAppBar(
      color: colorScheme.surface,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.location_on_outlined, color: colorScheme.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LocationPage()),
              );
            },
            iconSize: 30,
          ),
          IconButton(
            icon: Icon(Icons.route_outlined, color: colorScheme.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RoutePage()),
              );
            },
            iconSize: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.mic_none_rounded, color: colorScheme.primary, size: 30),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: false,
                    onChanged: (value) {},
                    activeColor: colorScheme.primary,
                  ),
                ),
                Icon(Icons.keyboard_alt_outlined, color: colorScheme.primary, size: 30),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.history_outlined, color: colorScheme.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
            },
            iconSize: 30,
          ),
          IconButton(
            icon: Icon(Icons.calendar_month_outlined, color: colorScheme.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarPage()),
              );
            },
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
