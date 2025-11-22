import 'package:ahmed_portfolio/screens/home_screen.dart';
import 'package:ahmed_portfolio/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Ahmed Zein Elabedin - Portfolio',
    theme: ThemeData(
      primaryColor: const Color(0xFF4F46E5),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4F46E5),
        primary: const Color(0xFF4F46E5),
      ),
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      useMaterial3: true,
    ),
    home: const SplashScreen(),
    debugShowCheckedModeBanner: false,
  );
}
