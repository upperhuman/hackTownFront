import 'package:flutter/material.dart';
import '/widgets/navigation_panel.dart';
import '/widgets/search_bar.dart';
import '/widgets/search_mobile_bar.dart';
import '/widgets/content_area.dart';
import '/widgets/bottom_navigation_panel.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const MobileMainPage();
        } else {
          return const DesktopMainPage();
        }
      },
    );
  }
}

class DesktopMainPage extends StatelessWidget {
  const DesktopMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          NavigationPanel(), // Левая панель
          Expanded(
            child: Column(
              children: [
                DesktopSearchBar(),
                Expanded(child: ContentArea()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MobileMainPage extends StatelessWidget {
  const MobileMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBarMobile(), // Верхняя панель: поисковая строка, UserProfile, Settings
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // Убираем стандартную кнопку "назад"
      ),
      body: const ContentArea(), // Основной контент
      bottomNavigationBar: const BottomNavigationPanel(), // Нижняя навигационная панель
    );
  }
}

