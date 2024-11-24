import 'package:flutter/material.dart';
import 'package:hack_town_front/main.dart';
import '/pages/main_pages/settings_page.dart';
import '/pages/main_pages/user_profile_page.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchBarMobile extends StatelessWidget {
  const SearchBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
          iconSize: 30,
        ),
        Expanded(
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "search_modile_bar.find_event".tr(),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: const Color.fromARGB(255, 172, 158, 158)),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.account_circle_outlined, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfilePage()),
            );
          },
          iconSize: 30,
        ),
      ],
    );
  }
}
