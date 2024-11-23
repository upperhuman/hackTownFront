import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

// Language Page
class SettingsLanguagePage extends StatelessWidget {
  const SettingsLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/SettingsBackground2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          AppBar(
            title: const Text('Мова'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          const Align(
            child: LanguageButtons(),
          ),
        ],
      ),
    );
  }
}

class LanguageButtons extends StatefulWidget {
  const LanguageButtons({super.key});

  @override
  State<LanguageButtons> createState() => _LanguageButtonsState();
}

class _LanguageButtonsState extends State<LanguageButtons> {
  final List<String> genderItems = [
    '🇺🇦 Українська',
    '🇺🇸 English',
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.language, size: 24, color: Colors.black),
            const SizedBox(width: 8),
            const Text(
              'Оберіть свою мову...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField2<String>(
  isExpanded: true,
  decoration: InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    fillColor: Colors.white,
    filled: true,
  ),
  items: genderItems
      .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ))
      .toList(),
  onChanged: (value) {
  },
  onSaved: (value) {
    selectedValue = value.toString();
  },
  buttonStyleData: const ButtonStyleData(
    padding: EdgeInsets.only(right: 8),
  ),
  iconStyleData: const IconStyleData(
    icon: Icon(
      Icons.arrow_drop_down,
      color: Colors.black45,
    ),
    iconSize: 24,
  ),
  dropdownStyleData: DropdownStyleData(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
    ),
  ),
  menuItemStyleData: const MenuItemStyleData(
    padding: EdgeInsets.symmetric(horizontal: 16),
  ),
),
          ],
        ),
      ),
    );
  }
}

