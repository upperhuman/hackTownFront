import 'package:flutter/material.dart';
import '/pages/main_pages/location_page.dart';
import '../pages/route_page/route_page.dart';
import '/pages/main_pages/calendar_page.dart';
import '/pages/main_pages/history_page.dart';
import '/pages/main_pages/settings_page.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.location_on_outlined, color: Theme.of(context).iconTheme.color),
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
                icon: Icon(Icons.route_outlined, color: Theme.of(context).iconTheme.color),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RoutePage()),
                  );
                },
                iconSize: 45,
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: Icon(Icons.calendar_month_outlined, color: Theme.of(context).iconTheme.color),
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
                icon: Icon(Icons.history_outlined, color: Theme.of(context).iconTheme.color),
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
            icon: Icon(Icons.settings_outlined, color: Theme.of(context).iconTheme.color),
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
