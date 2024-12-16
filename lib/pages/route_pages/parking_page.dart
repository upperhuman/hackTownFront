import 'package:hack_town_front/pages/main_pages/user_profile_page.dart';
import 'package:hack_town_front/widgets/bottom_navigation_panel.dart';
import 'package:hack_town_front/widgets/navigation_panel.dart';
import 'package:flutter/material.dart';

class ParkingPage extends StatelessWidget {
  const ParkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < constraints.maxHeight) {
          return const MobileParkingPage();
        } else {
          return const DesktopParkingPage();
        }
      },
    );
  }
}

class DesktopParkingPage extends StatefulWidget {
  const DesktopParkingPage({super.key});

  @override
  State<DesktopParkingPage> createState() => _DesktopParkingPageState();
}

class _DesktopParkingPageState extends State<DesktopParkingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const NavigationPanel(),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "parking_page",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 70,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 45,
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserProfilePage()),
                );
              },
              iconSize: 45,
            ),
          ),
        ],
      ),
    );
  }
}

class MobileParkingPage extends StatefulWidget {
  const MobileParkingPage({super.key});

  @override
  State<MobileParkingPage> createState() => _MobileParkingPageState();
}

class _MobileParkingPageState extends State<MobileParkingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("parking_page"),
              ],
            ),
          ),
          Positioned(
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 35,
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(Icons.account_circle_outlined, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserProfilePage()),
                );
              },
              iconSize: 35,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationPanel(),
    );
  }
}