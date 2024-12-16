import 'package:hack_town_front/pages/main_pages/user_profile_page.dart';
import 'package:hack_town_front/widgets/bottom_navigation_panel.dart';
import 'package:hack_town_front/widgets/navigation_panel.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < constraints.maxHeight) {
          return const MobileShopPage();
        } else {
          return const DesktopShopPage();
        }
      },
    );
  }
}

class DesktopShopPage extends StatefulWidget {
  const DesktopShopPage({super.key});

  @override
  State<DesktopShopPage> createState() => _DesktopShopPageState();
}

class _DesktopShopPageState extends State<DesktopShopPage> {
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
                  "shop_page",
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

class MobileShopPage extends StatefulWidget {
  const MobileShopPage({super.key});

  @override
  State<MobileShopPage> createState() => _MobileShopPageState();
}

class _MobileShopPageState extends State<MobileShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("shop_page"),
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