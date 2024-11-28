import 'package:flutter/material.dart';
import '/widgets/navigation_panel.dart';
import '/widgets/search_bar.dart';
import '/widgets/search_mobile_bar.dart';
import '/widgets/content_area.dart';
import '/widgets/bottom_navigation_panel.dart';
import '/pages/main_pages/test_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < constraints.maxHeight) {
          return const MobileMainPage();
        } else {
          return const DesktopMainPage();
        }
      },
    );
  }
}

class DesktopMainPage extends StatefulWidget {
  const DesktopMainPage({super.key});

  @override
  State<DesktopMainPage> createState() => _DesktopMainPageState();
}

class _DesktopMainPageState extends State<DesktopMainPage> {
  bool isKeyboardInput = false; // Start with voice input (false)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Navigation panel
          const NavigationPanel(),
          // Main content
          Expanded(
            child: Column(
              children: [
                // Top panel with input toggle
                DesktopSearchBar(
                  isKeyboardInput: isKeyboardInput,
                  onSwitchChanged: (value) {
                    setState(() {
                      isKeyboardInput = value;
                    });
                    if (value) {
                      // Navigate to TestPage when switching to keyboard input
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TestPage()),
                      );
                    } else {
                      // Navigate back to the main page when switching to voice input
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MainPage()),
                            (Route<dynamic> route) => false,
                      );
                    }
                  },
                ),
                // Content in the middle of the page
                const Expanded(child: ContentArea()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MobileMainPage extends StatefulWidget {
  const MobileMainPage({super.key});

  @override
  State<MobileMainPage> createState() => _MobileMainPageState();
}

class _MobileMainPageState extends State<MobileMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBarMobile(),
        automaticallyImplyLeading: false,
      ),
      body: const ContentArea(),
      bottomNavigationBar: const BottomNavigationPanel(),
    );
  }
}
