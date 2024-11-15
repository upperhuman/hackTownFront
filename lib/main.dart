import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

const String HOST = 'https://api.example.com';

const localeEnUs = Locale('en', 'US');
const localeUkUa = Locale('uk', 'UA');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        localeEnUs,
        localeUkUa
      ],
        path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          NavigationPanel(),
          Expanded(
            child: Column(
              children: [
                SearchBar(),
                Expanded(
                  child: ContentArea(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

// Location Page
class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: const Align(
        child: UserProfileButtons()
      )
    );
  }
}

// Buttons on the Location Page
class LocationButtons extends StatelessWidget {
  const LocationButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}

// Route page
class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route'),
      ),
      body: const Align(
        child: UserProfileButtons()
      )
    );
  }
}

// Buttons on the Route Page
class RouteButtons extends StatelessWidget {
  const RouteButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}

// Calendar Page
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: const Align(
        child: UserProfileButtons()
      )
    );
  }
}

// Buttons on the Calendar Page
class CalendarButtons extends StatelessWidget {
  const CalendarButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}

// History Page
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: const Align(
        child: UserProfileButtons()
      )
    );
  }
}

// Buttons on the History Page
class HistoryButtons extends StatelessWidget {
  const HistoryButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}

// Search Bar on the Main Page
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Знайти івент...",
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search_outlined, color: Colors.black, size: 35),
                  onPressed: () {},
                  ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                const Icon(Icons.mic_none_rounded, color: Colors.black, size: 35),
                
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
                
                const Icon(Icons.keyboard_alt_outlined, color: Colors.black, size: 35),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, color: Colors.black),
            onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserProfilePage()),
                  );
                },
            iconSize: 45,
          ),
        ],
      ),
    );
  }
}

// User Profile page
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: const Align(
        child: UserProfileButtons()
      )
    );
  }
}

// Buttons on the User Profile Page
class UserProfileButtons extends StatelessWidget {
  const UserProfileButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}

// Content Area on the Main PAge
class ContentArea extends StatelessWidget {
  const ContentArea({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/SettingsBackground.jpg', fit: BoxFit.cover),
          ),
          AppBar(
            title: const Text('Settings'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          const Align(
            child: SettingsButtons(),
          )
        ],
      ),
    );
  }
}

// Buttons on the Settings page
class SettingsButtons extends StatelessWidget {
  const SettingsButtons({super.key});
  @override
  Widget build(BuildContext context) {
    
    final ButtonStyle buttonStyle = TextButton.styleFrom(
      foregroundColor: Colors.black,
      textStyle: const TextStyle(
        fontFamily: 'InknutAntiqua',
        fontSize: 30,
      )
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            TextButton(
              style: buttonStyle,
              child: const Text('Language'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsLanguagePage()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              style: buttonStyle,
              child: const Text('Region'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsRegionPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              style: buttonStyle,
              child: const Text('Theme'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsThemePage()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              style: buttonStyle,
              child: const Text('Security'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsSecurityPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              style: buttonStyle,
              child: const Text('Notification'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsNotificationsPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              style: buttonStyle,
              child: const Text('FAQ'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsFAQPage()),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}

// Language Page
class SettingsLanguagePage extends StatelessWidget{
  const SettingsLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
      ),
      body: const Align(
        child: LanguageButtons()
      ),
    );
  }
}

// Buttons on the Language page
class LanguageButtons extends StatelessWidget {
  const LanguageButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}

// Region Page
class SettingsRegionPage extends StatelessWidget {
  const SettingsRegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Region'),
      ),
      body: const Align(
        child: RegionButtons()
      )
    );
  }
}

// Buttons on the Region page
class RegionButtons extends StatelessWidget {
  const RegionButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}

// Theme Page
class SettingsThemePage extends StatelessWidget {
  const SettingsThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
      ),
      body: const Align(
        child: ThemeButtons()
      )
    );
  }
}

// Buttons on the Theme page
class ThemeButtons extends StatelessWidget {
  const ThemeButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}

// Security Page
class SettingsSecurityPage extends StatelessWidget {
  const SettingsSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security'),
      ),
      body: const Align(
        child: ThemeButtons()
      )
    );
  }
}

// Buttons on the Security page
class SecurityButtons extends StatelessWidget {
  const SecurityButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}

// Notifications Page
class SettingsNotificationsPage extends StatelessWidget {
  const SettingsNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: const Align(
        child: ThemeButtons()
      )
    );
  }
}

// Buttons on the Notifications page
class NotificationsButtons extends StatelessWidget {
  const NotificationsButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}

// FAQ Page
class SettingsFAQPage extends StatelessWidget {
  const SettingsFAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
      ),
      body: const Align(
        child: ThemeButtons()
      )
    );
  }
}

// Buttons on the FAQ page
class FAQButtons extends StatelessWidget {
  const FAQButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}