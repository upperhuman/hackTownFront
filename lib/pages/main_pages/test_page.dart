import 'package:flutter/material.dart';
import '/widgets/navigation_panel.dart';
import '/pages/main_pages/user_profile_page.dart';
import '/widgets/search_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import '/pages/main_pages/main_page.dart';

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
                          const Text(
                            "Привіт, давай визначимо твої побажання",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField("Тип події"),
                          const SizedBox(height: 10),
                          _buildTextField("Оберіть кількість людей"),
                          const SizedBox(height: 10),
                          _buildTextField("Оберіть свій бюджет"),
                          const SizedBox(height: 10),
                          _buildTextField("Тривалість події"),
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
                              backgroundColor: Colors.teal,
                            ),
                            child: const Text(
                              "Знайти",
                              style: TextStyle(fontSize: 18, color: Colors.white),
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

  Widget _buildTextField(String label) {
    return SizedBox(
      width: 400, // Set the width here
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
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
        title: const Text('Мобільна версія'),
      ),
      body: const Center(
        child: Text(
          'Контент для мобільної версії',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
