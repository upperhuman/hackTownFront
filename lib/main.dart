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
        path: 'assets/translations', // <-- change the path of the translation files
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
          NavigationPanel(), // Навігаційна панель з іконками
          Expanded(
            child: Column(
              children: [
                SearchBar(), // Пошукова строка з перемикачем
                Expanded(
                  child: ContentArea(), // Основний контент
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.location_on, color: Colors.black),
                onPressed: () {},
                iconSize: 30,
              ),
              const SizedBox(height: 16),
              IconButton(
                icon: const Icon(Icons.compare_arrows, color: Colors.black),
                onPressed: () {},
                iconSize: 30,
              ),
              const SizedBox(height: 16),
              IconButton(
                icon: const Icon(Icons.access_time, color: Colors.black),
                onPressed: () {},
                iconSize: 30,
              ),
              const SizedBox(height: 16),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.black),
                onPressed: () {},
                iconSize: 30,
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Знайти івент...",
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.grey),
                  onPressed: () {},
                  ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 220.0,
            child: Row(
              children: [
                const Icon(Icons.mic, color: Colors.grey),
                Switch(
                  value: false,
                  onChanged: (value) {},
                ),
                const Icon(Icons.keyboard, color: Colors.grey),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.grey),
            onPressed: () {},
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}

class ContentArea extends StatelessWidget {
  const ContentArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(""),
      ),
    );
  }
}
