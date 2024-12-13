import 'package:flutter/material.dart';
import '/pages/route_pages/cinema_page.dart';
import '/pages/route_pages/restaurant_page.dart';
import '/pages/route_pages/shop_page.dart';
import '/pages/route_pages/parking_page.dart';

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
