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
  State<DesktopMainPage> createState() => _DesktopMainPage();
}

class _DesktopMainPage extends State<DesktopMainPage> {
  @override
  
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          NavigationPanel(),
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

class MobileMainPage extends StatefulWidget {
  const MobileMainPage({super.key});
  
  @override
  State<MobileMainPage> createState() => _MobileMainPage();
}

class _MobileMainPage extends State<MobileMainPage> {
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



