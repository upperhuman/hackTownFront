import 'package:flutter/material.dart';
import '/pages/main_pages/location_page.dart';
import '/pages/main_pages/route_page.dart';
import '/pages/main_pages/calendar_page.dart';
import '/pages/main_pages/history_page.dart';

class BottomNavigationPanel extends StatelessWidget {
  const BottomNavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.location_on_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LocationPage()),
              );
            },
            iconSize: 30,
          ),
          IconButton(
            icon: const Icon(Icons.route_outlined, color: Colors.black),
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
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                const Icon(Icons.mic_none_rounded, color: Colors.black, size: 30),
                
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: false,
                    onChanged: (value) {},
                    activeColor: Colors.grey[350],
                    inactiveThumbColor: Colors.grey[350],
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white,
                  ),
                ),
                
                const Icon(Icons.keyboard_alt_outlined, color: Colors.black, size: 30),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.history_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
            },
            iconSize: 30,
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined, color: Colors.black),
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
