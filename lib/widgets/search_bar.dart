import 'package:flutter/material.dart';
import '/pages/main_pages/user_profile_page.dart';
import 'package:easy_localization/easy_localization.dart';

class DesktopSearchBar extends StatefulWidget {
  // Parameters to pass the switch state and the callback to change it
  final bool isKeyboardInput;
  final ValueChanged<bool> onSwitchChanged;

  const DesktopSearchBar({
    super.key,
    required this.isKeyboardInput,
    required this.onSwitchChanged,
  });

  @override
  State<DesktopSearchBar> createState() => _DesktopSearchBarState();
}

class _DesktopSearchBarState extends State<DesktopSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Search input field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "search_modile_bar.find_event".tr(),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search_outlined, size: 35),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          // Container for the switch and icons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                // Microphone icon
                const Icon(Icons.mic_none_rounded, size: 35),
                // Switch to toggle between voice and keyboard input
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: widget.isKeyboardInput, // Current state of the switch
                    onChanged: (value) {
                      // Update the switch state via the callback
                      widget.onSwitchChanged(value);
                    },
                    activeColor: Colors.blue, // Color of the switch in the active state
                    inactiveThumbColor: Colors.grey, // Color of the switch in the inactive state
                    activeTrackColor: Colors.blue.withOpacity(0.5), // Color of the track in the active state
                    inactiveTrackColor: Colors.grey.withOpacity(0.5), // Color of the track in the inactive state
                  ),
                ),
                // Keyboard icon
                const Icon(Icons.keyboard_alt_outlined, size: 35),
              ],
            ),
          ),
          const Spacer(),
          // User profile icon
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
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
