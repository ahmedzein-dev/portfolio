import 'package:flutter/material.dart';

class AppStyle {
  static const Color primaryColor = Color(0xFFF8F7F2);
  static const Color secondaryColor = Color(0xFFF2F2F2);

  static const Gradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xFF2C3E50),
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle cardDescription = TextStyle(
    fontSize: 16,
    color: Colors.white70,
    height: 1.4,
  );
}
