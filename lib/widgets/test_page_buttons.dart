import 'package:flutter/material.dart';

// Test page buttons dart
Widget buildTextField(String label) {
  return SizedBox(
    width: 400,
    child: TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );
}
