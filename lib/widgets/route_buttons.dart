import 'package:flutter/material.dart';
import 'package:hack_town_front/widgets/navigation_panel.dart';

class RouteButtons extends StatelessWidget {
  const RouteButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDropdownItem(
            context,
            "Cinema",
            Icons.movie,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CinemaPage()),
              );
            },
          ),
          buildDropdownItem(
            context,
            "Restaurant",
            Icons.restaurant,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RestaurantPage()),
              );
            },
          ),
          buildDropdownItem(
            context,
            "Shop",
            Icons.shopping_cart,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShopPage()),
              );
            },
          ),
          buildDropdownItem(
            context,
            "Parking",
            Icons.local_parking,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ParkingPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDropdownItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(icon, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Пример страниц
class CinemaPage extends StatelessWidget {
  const CinemaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              const NavigationPanel(),
              Expanded(
                child: Container(
                  color: colorScheme.background,
                  child: Center(
                    child: Text(
                      'Main Content',
                      style: TextStyle(fontSize: 24, color: colorScheme.onBackground),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 70, // Сдвигаем стрелку вправо (70 ширина панели + 16 отступ)
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: colorScheme.primary),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 45,
            ),
          ),
        ],
      ),
    );
  }
}


class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurant")),
      body: const NavigationPanel()
    );
  }
}

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop")),
      body: const NavigationPanel()
    );
  }
}

class ParkingPage extends StatelessWidget {
  const ParkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parking")),
      body: const NavigationPanel()
    );
  }
}
