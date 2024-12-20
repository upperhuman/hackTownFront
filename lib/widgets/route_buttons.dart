import 'package:flutter/material.dart';
import 'package:hack_town_front/widgets/iFrame.dart';
import 'package:hack_town_front/dtos/event_route.dart';
import '../main.dart';
import '/pages/route_pages/cinema_page.dart';
import '/pages/route_pages/restaurant_page.dart';
import '/pages/route_pages/shop_page.dart';
import '/pages/route_pages/parking_page.dart';

class RouteButtons extends StatelessWidget {
  List<EventRouteDTO>? eventRoutes;
  RouteButtons(this.eventRoutes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDropdownItem(
            context,
            eventRoutes![0].name,
            Icons.movie,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const IFramePage(
                    url: "https://www.google.com/maps/embed/v1/directions?key=AIzaSyCE5WTbBE1wj6sOibVurOLXsPwlVqAQP5U&origin=48.4651772,35.0437122&destination=48.4682922,35.0400722&waypoints=48.4655,35.054|48.4656,35.0545",
                  ),
                ),
              );
            },
          ),
          buildDropdownItem(
            context,
            eventRoutes![1].name,
            Icons.restaurant,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const IFramePage(
                    url: "https://www.google.com/maps/embed/v1/directions?key=AIzaSyCE5WTbBE1wj6sOibVurOLXsPwlVqAQP5U&origin=48.4651772,35.0437122&destination=48.4682922,35.0400722&waypoints=48.4655,35.054|48.4656,35.0545",
                  ),
                ),
              );
            },
          ),
          buildDropdownItem(
            context,
            eventRoutes![2].name,
            Icons.shopping_cart,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const IFramePage(
                    url: "https://www.google.com/maps/embed/v1/directions?key=AIzaSyCE5WTbBE1wj6sOibVurOLXsPwlVqAQP5U&origin=48.4651772,35.0437122&destination=48.4682922,35.0400722&waypoints=48.4655,35.054|48.4656,35.0545",
                  ),
                ),
              );
            },
          ),
          buildDropdownItem(
            context,
            eventRoutes![3].name,
            Icons.local_parking,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const IFramePage(
                    url: "https://www.google.com/maps/embed/v1/directions?key=AIzaSyCE5WTbBE1wj6sOibVurOLXsPwlVqAQP5U&origin=48.4651772,35.0437122&destination=48.4682922,35.0400722&waypoints=48.4655,35.054|48.4656,35.0545",
                  ),
                ),
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
