import '/widgets/test_page_buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import '/pages/main_pages/main_page.dart';
import '/widgets/navigation_panel.dart';
import 'package:flutter/material.dart';
import '/widgets/search_bar.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

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
  bool isKeyboardInput = true; // For toggling between keyboard and voice input

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
                    if (!value) {
                      // Navigate to MainPage
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MainPage()),
                            (Route<dynamic> route) => false,
                      );
                    }
                  },
                ),
                // Content in the middle of the page
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "test_page.greeting".tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          buildTextField("test_page.event_type".tr()),
                          const SizedBox(height: 10),
                          buildTextField("test_page.number_of_people".tr()),
                          const SizedBox(height: 10),
                          buildTextField("test_page.budget".tr()),
                          const SizedBox(height: 10),
                          buildTextField("test_page.duration".tr()),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Logic for the "Find" button
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 40.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.grey,
                            ),
                            child: Text(
                              "test_page.find".tr(),
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
        title: Text("test_page.mobile".tr()),
      ),
      body: Center(
        child: Text(
           "test_page.mobile_content".tr(),
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
