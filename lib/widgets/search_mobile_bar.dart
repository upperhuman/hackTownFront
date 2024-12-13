import 'package:flutter/material.dart';
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
          icon: Icon(
            Icons.settings_outlined,
            color: Theme.of(context).scaffoldBackgroundColor
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
          iconSize: 35,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5),
                hintText: "search_modile_bar.find_event".tr(),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search_outlined,
                      size: 35),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),   
                ),
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.account_circle_outlined,
            color: Theme.of(context).scaffoldBackgroundColor
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfilePage()),
            );
          },
          iconSize: 35,
        ),
      ],
    );
  }
}
